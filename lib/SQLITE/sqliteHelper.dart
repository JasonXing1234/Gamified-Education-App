import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/PracticeAttemptModel.dart';
import '../models/PracticeModel.dart';
import '../models/UserModel.dart';
import '../models/quizAttemptModel.dart';
import '../models/quizModel.dart';
import '../models/quizQuestionModel.dart';
import '../models/readingModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    print('Database path: $path'); // Debugging database path
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Creating database schema...');

    try {
      await db.execute('''
      CREATE TABLE UserModel (
        key TEXT PRIMARY KEY,
        email TEXT,
        userId TEXT,
        deviceToken TEXT,
        userName TEXT,
        profilePic TEXT,
        bannerImage TEXT,
        numTickets INTEGER,
        totalTimeSpent INTEGER DEFAULT 0,
        quizList TEXT,
        readingList TEXT,
        practiceList TEXT,
        accessories TEXT,
        ifEachModuleComplete TEXT,
        currentTask TEXT,
        password TEXT,
        isLoggedIn INTEGER DEFAULT 0
      )
    ''');
      print('UserModel table created.');
    } catch (e) {
      print('Error creating UserModel table: $e');
    }

    print('Database schema created successfully.');
  }


  Future<int> insertUser(Map<String, dynamic> userData, String password) async {
    try {
      final db = await database;

      userData['quizList'] = jsonEncode(userData['quizList']);
      userData['readingList'] = jsonEncode(userData['readingList']);
      userData['practiceList'] = jsonEncode(userData['practiceList']);
      userData['accessories'] = jsonEncode(userData['accessories']);
      userData['ifEachModuleComplete'] = jsonEncode(userData['ifEachModuleComplete']);
      userData['currentTask'] = userData['currentTask'] ?? '';
      userData['isLoggedIn'] = userData['isLoggedIn'] == true ? 1 : 0;

      // Add password field to user data
      userData['password'] = password;

      int result = await db.insert(
        'UserModel',
        userData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print('User inserted successfully with ID: $result');
      return result;
    } catch (e) {
      print('Error inserting user into SQLite: $e');
      return -1;
    }
  }

  Future<int> loginUser(String userId) async {
    final db = await database;
    await db.update(
      'UserModel',
      {'isLoggedIn': 1},
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return 1;
  }

  Future<UserModel?> getLoggedInUser() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'UserModel',
      where: 'isLoggedIn = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (result.isNotEmpty) {
      Map<String, dynamic> userData = Map<String, dynamic>.from(result.first);
      userData['isLoggedIn'] = userData['isLoggedIn'] == 1;
      return UserModel.fromJson(userData);
    }
    return null;
  }

  Future<int> logoutUser() async {
    final db = await database;
    // Set isLoggedIn to 0 for the currently logged-in user.
    // If you allow multiple users, you may want to update by userId.
    return await db.update(
      'UserModel',
      {'isLoggedIn': 0},
      where: 'isLoggedIn = ?',
      whereArgs: [1],
    );
  }

  Future<int> insertQuizAttempt(String userId, String quizId, int quizScore) async {
    try {
      final db = await database;

      // Get user data
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found');
        return -1;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Find quiz
      QuizModel? quiz = user.quizList?.firstWhere(
              (q) => q.quizId == quizId,
          orElse: () => QuizModel(quizId: quizId, attempts: []));

      if (quiz != null) {
        quiz.attempts.add(QuizAttemptModel(
          attemptId: quiz.attempts.length + 1,
          quizId: quizId,
          quizScore: quizScore,
          attemptTimestamp: DateTime.now(),
          questions: [],
        ));
      }

      // Update user in DB
      await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('New quiz attempt inserted successfully');
      return quiz!.attempts.length;
    } catch (e) {
      print('Error inserting quiz attempt: $e');
      return -1;
    }
  }

  Future<int> insertPracticeAttempt(String userId, String practiceId, int practiceScore) async {
    try {
      final db = await database;

      // Get user data
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found');
        return -1;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Find practice
      PracticeModel? practice = user.practiceList?.firstWhere(
              (p) => p.practiceId == practiceId,
          orElse: () => PracticeModel(practiceId: practiceId, attempts: []));

      if (practice != null) {
        practice.attempts.add(PracticeAttemptModel(
          attemptId: practice.attempts.length + 1,
          questions: [],
        ));
      }

      // Update user in DB
      await db.update(
        'UserModel',
        {'practiceList': jsonEncode(user.practiceList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('New practice attempt inserted successfully');
      return practice!.attempts.length;
    } catch (e) {
      print('Error inserting practice attempt: $e');
      return -1;
    }
  }

  Future<int> updateDisplayName(String userId, String displayName) async {
    try {
      final db = await database;

      int result = await db.update(
        'UserModel',
        {'userName': displayName},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Display name updated successfully in SQLite.');

      // Update Firebase user profile as well
      final DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();
      await firebaseRef.child('profile').child(userId).update({'userName': displayName});

      print('Display name updated successfully in Firebase.');
      return result;
    } catch (e) {
      print('Error updating display name: $e');
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (maps.isNotEmpty) {
        maps[0]['quizList'] = jsonDecode(maps[0]['quizList']);
        maps[0]['readingList'] = jsonDecode(maps[0]['readingList']);
        maps[0]['accessories'] = jsonDecode(maps[0]['accessories']);
        maps[0]['ifEachModuleComplete'] = jsonDecode(maps[0]['ifEachModuleComplete']);
        return maps[0];
      }
      return null;
    } catch (e) {
      print('Error fetching user from SQLite: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(String email, String password) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'UserModel',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (maps.isNotEmpty) {
        return maps.first;
      }
      return null;
    } catch (e) {
      print('Error fetching user from SQLite: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchUserFromFirebase(String userId) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref();
      DataSnapshot snapshot = await ref.child('profile').child(userId).get();

      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      }
      return null;
    } catch (e) {
      print('Error fetching user from Firebase: $e');
      return null;
    }
  }

  Future<int> updateReadingProgress(String userId, int lessonNumber, int progress) async {
    try {
      final db = await database;

      // Fetch user data
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found');
        return -1;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Ensure readingList is not null
      user.readingList = List.generate(6, (index) => readingModel(readingID: 'reading_$index', progress: 0));

      // Find the correct reading and update progress
      readingModel? reading = user.readingList?.firstWhere(
            (r) => r.readingID == 'reading_$lessonNumber',
        orElse: () {
          // Ensure reading exists before updating progress
          print('Reading not found, creating new one.');
          readingModel newReading = readingModel(readingID: 'reading_$lessonNumber', progress: progress);
          user.readingList!.add(newReading);
          return newReading;
        },
      );

      if (reading != null) {
        reading.progress = progress;
      }

      // Update user data in SQLite
      int result = await db.update(
        'UserModel',
        {'readingList': jsonEncode(user.readingList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Reading progress updated successfully.');
      return result;
    } catch (e) {
      print('Error updating reading progress: $e');
      return -1;
    }
  }

  Future<List<readingModel>> getReadingList(String userId) async {
    try {
      final db = await database;

      // Fetch user data
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found');
        return [];
      }

      UserModel user = UserModel.fromJson(userData.first);
      return user.readingList ?? [];
    } catch (e) {
      print('Error fetching reading list: $e');
      return [];
    }
  }

  Future<int> updateQuizScore(String userId, int quizNumber, int quizResult) async {
    try {
      final db = await database;

      // Fetch user data
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found');
        return -1;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Find quiz and update score
      QuizModel? quiz = user.quizList?.firstWhere(
              (q) => q.quizId == 'quiz$quizNumber',
          orElse: () => QuizModel(quizId: 'quiz$quizNumber', attempts: []));

      if (quiz != null) {
        // Update latest attempt or add a new attempt
        if (quiz.attempts.isNotEmpty) {
          quiz.attempts.last.quizScore = quizResult;
        } else {
          quiz.attempts.add(QuizAttemptModel(
            attemptId: quiz.attempts.length + 1,
            quizId: 'quiz$quizNumber',
            quizScore: quizResult,
            attemptTimestamp: DateTime.now(),
            questions: [],
          ));
        }
      }

      // Update user data in SQLite
      int result = await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Quiz score updated successfully.');
      return result;
    } catch (e) {
      print('Error updating quiz score: $e');
      return -1;
    }
  }


  Future<int?> getNumTickets(String userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        'UserModel',
        columns: ['numTickets'],
        where: 'userId = ?',
        whereArgs: [userId],
      );
      if (result.isNotEmpty) {
        return result.first['numTickets'] as int?;
      }
      return null;
    } catch (e) {
      print('Error fetching number of tickets: $e');
      return null;
    }
  }

  Future<List<dynamic>> getAccessories(String userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        'UserModel',
        columns: ['accessories'],
        where: 'userId = ?',
        whereArgs: [userId],
      );
      if (result.isNotEmpty) {
        return jsonDecode(result.first['accessories']) as List<dynamic>;
      }
      return [];
    } catch (e) {
      print('Error fetching accessories: $e');
      return [];
    }
  }

  Future<int> updateEndTimestamp(String userId, String questionId, String endTimeStamp, int attemptId) async {
    try {
      final db = await database;

      // Find the matching quiz attempt
      List<Map<String, dynamic>> attempts = await db.query(
        'QuizAttempts',
        where: 'userId = ? AND attemptId = ?',
        whereArgs: [userId, attemptId],
      );

      if (attempts.isEmpty) {
        print('No matching attempt found.');
        return -1;
      }

      // Find the matching question
      int result = await db.update(
        'QuizQuestionModel',
        {'endTimeStamp': endTimeStamp},
        where: 'questionId = ? AND attemptId = ?',
        whereArgs: [questionId, attemptId],
      );

      if (result > 0) {
        print('End timestamp updated successfully for Attempt ID: $attemptId');
      } else {
        print('No matching question found for Attempt ID: $attemptId');
      }

      return result;
    } catch (e) {
      print('Error updating end timestamp: $e');
      return -1;
    }
  }


  Future<int> updateBeginTimestamp(String userId, String questionId, String beginTimeStamp, int attemptId) async {
    try {
      final db = await database;

      // Find the matching quiz attempt
      List<Map<String, dynamic>> attempts = await db.query(
        'QuizAttempts',
        where: 'userId = ? AND attemptId = ?',
        whereArgs: [userId, attemptId],
      );

      if (attempts.isEmpty) {
        print('No matching attempt found.');
        return -1;
      }

      // Find the matching question
      int result = await db.update(
        'QuizQuestionModel',
        {'beginTimeStamp': beginTimeStamp},
        where: 'questionId = ? AND attemptId = ?',
        whereArgs: [questionId, attemptId],
      );

      if (result > 0) {
        print('Begin timestamp updated successfully for Attempt ID: $attemptId');
      } else {
        print('No matching question found for Attempt ID: $attemptId');
      }

      return result;
    } catch (e) {
      print('Error updating begin timestamp: $e');
      return -1;
    }
  }


  Future<void> checkDatabaseSchema() async {
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
      print('Database tables: $result');
    } catch (e) {
      print('Error fetching database schema: $e');
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      print('Upgrading database from version $oldVersion to $newVersion...');
      await db.execute("ALTER TABLE UserModel ADD COLUMN quizList TEXT");
      await db.execute("ALTER TABLE UserModel ADD COLUMN readingList TEXT");
      await db.execute("ALTER TABLE UserModel ADD COLUMN accessories TEXT");
      await db.execute("ALTER TABLE UserModel ADD COLUMN ifEachModuleComplete TEXT");
      print('Database upgraded successfully.');
    }
  }

  Future<void> resetDatabase() async {
    try {
      final db = await database;

      // Drop all tables
      await db.execute("DROP TABLE IF EXISTS UserModel");
      await db.execute("DROP TABLE IF EXISTS QuizModel");
      await db.execute("DROP TABLE IF EXISTS QuizAttempts");
      await db.execute("DROP TABLE IF EXISTS QuizQuestionModel");
      await db.execute("DROP TABLE IF EXISTS ReadingModel");

      print('All tables dropped. Recreating database...');

      // Recreate database
      await _onCreate(db, 2); // Replace 2 with the current version number

      print('Database reset successfully.');
    } catch (e) {
      print('Error resetting database: $e');
    }
  }

  Future<int> updateCurrentTask(String userId, String currentTask) async {
    try {
      final db = await database;

      int result = await db.update(
        'UserModel',
        {'currentTask': currentTask},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Current task updated to: $currentTask for userId: $userId');
      return result;
    } catch (e) {
      print('Error updating currentTask: $e');
      return -1;
    }
  }

  Future<int> updateIfEachModuleComplete(String userId, int lessonNumber) async {
    try {
      final db = await database;
      List<Map<String, dynamic>> userRecords = await db.query(
        'UserModel',
        columns: ['ifEachModuleComplete'],
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userRecords.isEmpty) {
        print('User not found.');
        return -1;
      }

      List<List<bool>> moduleCompletion = (jsonDecode(userRecords.first['ifEachModuleComplete']) as List)
          .map((e) => List<bool>.from(e))
          .toList();

      int moduleIndex = lessonNumber - 1;
      if (moduleIndex < 0 || moduleIndex >= moduleCompletion.length) {
        print('Invalid module index: $moduleIndex');
        return -1;
      }

      moduleCompletion[moduleIndex][0] = true;

      int result = await db.update(
        'UserModel',
        {'ifEachModuleComplete': jsonEncode(moduleCompletion)},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('ifEachModuleComplete updated successfully for lesson $lessonNumber');
      return result;
    } catch (e) {
      print('Error updating ifEachModuleComplete: $e');
      return -1;
    }
  }

  Future<int> updateIfEachModuleCompleteForQuiz(String userId, int quizNumber) async {
    try {
      final db = await database;
      List<Map<String, dynamic>> userRecords = await db.query(
        'UserModel',
        columns: ['ifEachModuleComplete'],
        where: 'userId = ?',
        whereArgs: [userId],
      );
      if (userRecords.isEmpty) {
        print('User not found.');
        return -1;
      }
      List<List<bool>> moduleCompletion = (jsonDecode(userRecords.first['ifEachModuleComplete']) as List)
          .map((e) => List<bool>.from(e))
          .toList();
      int moduleIndex = quizNumber - 1;
      if (moduleIndex < 0 || moduleIndex >= moduleCompletion.length) {
        print('Invalid module index: $moduleIndex');
        return -1;
      }
      moduleCompletion[moduleIndex][1] = true;
      int result = await db.update(
        'UserModel',
        {'ifEachModuleComplete': jsonEncode(moduleCompletion)},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('ifEachModuleComplete updated successfully for quiz $quizNumber');
      return result;
    } catch (e) {
      print('Error updating ifEachModuleComplete for quiz: $e');
      return -1;
    }
  }

  Future<Map<int, double>> getModuleProgress(String userId) async {
    try {
      final db = await database;
      List<Map<String, dynamic>> userRecords = await db.query(
        'UserModel',
        columns: ['ifEachModuleComplete'],
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userRecords.isEmpty) {
        print('User not found.');
        return {};
      }
      List<List<bool>> moduleCompletion = (jsonDecode(userRecords.first['ifEachModuleComplete']) as List)
          .map((e) => List<bool>.from(e))
          .toList();
      Map<int, double> moduleProgress = {};
      for (int i = 0; i < moduleCompletion.length; i++) {
        int completedTasks = moduleCompletion[i].where((task) => task).length;
        moduleProgress[i] = completedTasks.toDouble();
      }

      print('Module progress fetched successfully: $moduleProgress');
      return moduleProgress;
    } catch (e) {
      print('Error fetching module progress: $e');
      return {};
    }
  }

  Future<Map<String, int>?> getNextIncompleteTask(String userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        'UserModel',
        columns: ['ifEachModuleComplete'],
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (result.isEmpty) {
        print("User data not found.");
        return null;
      }

      List<List<bool>> ifEachModuleComplete = (result.first['ifEachModuleComplete'] != null)
          ? (jsonDecode(result.first['ifEachModuleComplete']) as List)
          .map((innerList) => List<bool>.from(innerList))
          .toList()
          : [];

      for (int moduleIndex = 0; moduleIndex < ifEachModuleComplete.length; moduleIndex++) {
        for (int taskIndex = 0; taskIndex < ifEachModuleComplete[moduleIndex].length; taskIndex++) {
          if (!ifEachModuleComplete[moduleIndex][taskIndex]) {
            print("Next incomplete task found: Module $moduleIndex, Task $taskIndex");
            return {'moduleIndex': moduleIndex, 'taskIndex': taskIndex};
          }
        }
      }

      print("All tasks completed!");
      return null;

    } catch (e) {
      print("Error retrieving next task: $e");
      return null;
    }
  }

  Future<int> insertPracticeQuestion({
    required String userId,
    required bool isCorrect,
    required int attemptCount,
    required List<String> incorrectAnswers,
    required int timeTaken,
  }) async {
    final db = await database;

    return await db.insert(
      'PracticeQuestionModel',
      {
        'userId': userId,
        'isCorrect': isCorrect ? 1 : 0,
        'attemptCount': attemptCount,
        'incorrectAnswers': jsonEncode(incorrectAnswers),
        'timeTaken': timeTaken,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getPracticeAttempts(String userId) async {
    final db = await database;
    return await db.query(
      'PracticeQuestionModel',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updatePracticeAttempt({
    required String userId,
    required String questionId,
    required bool isCorrect,
    required int attemptCount,
    required List<String> incorrectAnswers,
    required int timeTaken,
    required String endTimeStamp,
  }) async {
    final db = await database;

    return await db.update(
      'PracticeQuestionModel',
      {
        'isCorrect': isCorrect ? 1 : 0,
        'attemptCount': attemptCount,
        'incorrectAnswers': jsonEncode(incorrectAnswers),
        'timeTaken': timeTaken,
        'endTimeStamp': endTimeStamp,
      },
      where: 'userId = ? AND questionId = ?',
      whereArgs: [userId, questionId],
    );
  }

  Future<int> getTotalPracticeTime(String userId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(timeTaken) as totalTime FROM PracticeQuestionModel WHERE userId = ?',
      [userId],
    );
    return result.first['totalTime'] as int? ?? 0;
  }

  Future<int> updateEndTimestampForPractice(String userId, String questionId, String endTimeStamp, int attemptId, int attemptCount, List<String> incorrectAnswers, int timeTaken) async {
    try {
      final db = await database;

      int result = await db.update(
        'PracticeQuestions',
        {
          'endTimeStamp': endTimeStamp,
          'attemptCount': attemptCount,
          'incorrectAnswers': jsonEncode(incorrectAnswers),
          'timeTaken': timeTaken,
        },
        where: 'userId = ? AND questionId = ? AND attemptId = ?',
        whereArgs: [userId, questionId, attemptId],
      );

      print('Practice End timestamp updated successfully.');
      return result;
    } catch (e) {
      print('Error updating practice end timestamp: $e');
      return -1;
    }
  }

  Future<int> updateBeginTimestampForPractice(
      String userId, String questionId, String beginTimeStamp, int attemptId) async {
    try {
      final db = await database;

      int result = await db.update(
        'PracticeQuestions',
        {
          'beginTimeStamp': beginTimeStamp,
        },
        where: 'userId = ? AND questionId = ? AND attemptId = ?',
        whereArgs: [userId, questionId, attemptId],
      );

      print('Practice Start timestamp updated successfully.');
      return result;
    } catch (e) {
      print('Error updating practice start timestamp: $e');
      return -1;
    }
  }

}
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
    return await db.update(
      'UserModel',
      {'isLoggedIn': 0},
      where: 'isLoggedIn = ?',
      whereArgs: [1],
    );
  }

  Future<int> insertQuizAttempt(String userId, String quizNumber, int quizScore) async {
    try {
      final db = await database;

      // Ensure quizId is correctly formatted
      String quizId = quizNumber;

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

      // Work with a copy of the quiz list
      List<QuizModel> updatedQuizList = List.from(user.quizList ?? []);

      // Find the quiz in the list
      int quizIndex = updatedQuizList.indexWhere((q) => q.quizId == quizId);

      // Initialize first question for a new attempt
      List<QuizQuestionModel> initializedQuestions = List.generate(
        1,
            (index) => QuizQuestionModel(
          questionId: '$quizId-question$index',
          isCorrect: false,
          userAnswer: '',
          beginTimeStamp: DateTime.now(),
          endTimeStamp: DateTime.now().add(Duration(minutes: 1)), // Placeholder time
        ),
      );

      if (quizIndex == -1) {
        // If quiz not found, create a new one with the new attempt
        updatedQuizList.add(
          QuizModel(
            quizId: quizId,
            attempts: [
              QuizAttemptModel(
                attemptId: 1, // First attempt
                quizId: quizId,
                quizScore: quizScore,
                attemptTimestamp: DateTime.now(),
                questions: initializedQuestions,
              ),
            ],
          ),
        );
      } else {
        // If quiz exists, modify the existing quiz object
        QuizModel existingQuiz = updatedQuizList[quizIndex];

        List<QuizAttemptModel> updatedAttempts = List.from(existingQuiz.attempts)
          ..add(
            QuizAttemptModel(
              attemptId: existingQuiz.attempts.length + 1, // Increment attempt ID
              quizId: quizId,
              quizScore: quizScore,
              attemptTimestamp: DateTime.now(),
              questions: initializedQuestions,
            ),
          );

        // Replace the modified quiz object in the list
        updatedQuizList[quizIndex] = QuizModel(
          quizId: existingQuiz.quizId,
          attempts: updatedAttempts, // Properly nesting the attempts inside the quiz
        );
      }

      // Update the user model in the database with the modified quiz list
      await db.update(
        'UserModel',
        {'quizList': jsonEncode(updatedQuizList.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('New quiz attempt inserted successfully with initialized questions.');
      return updatedQuizList
          .firstWhere((quiz) => quiz.quizId == quizId)
          .attempts
          .length;
    } catch (e) {
      print('Error inserting quiz attempt: $e');
      return -1;
    }
  }

  Future<int> insertQuizQuestion(String userId, int attemptId, int quizNumber, int questionIndex) async {
    try {
      final db = await database;

      // Create new quiz question model
      QuizQuestionModel newQuestion = QuizQuestionModel(
        questionId: 'quiz$quizNumber-question$questionIndex',
        isCorrect: false,
        userAnswer: '',
        beginTimeStamp: DateTime.now(),
        endTimeStamp: DateTime.now().add(Duration(minutes: 1)), // Placeholder time
      );

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

      // Work with a copy of the quiz list
      List<QuizModel> updatedQuizList = List.from(user.quizList ?? []);

      // Find the quiz
      int quizIndex = updatedQuizList.indexWhere((q) => q.quizId == 'quiz$quizNumber');

      if (quizIndex == -1) {
        print('Quiz not found');
        return -1;
      }

      // Find the attempt
      QuizModel existingQuiz = updatedQuizList[quizIndex];
      int attemptIndex = existingQuiz.attempts.indexWhere((a) => a.attemptId == attemptId);

      if (attemptIndex == -1) {
        print('Attempt not found');
        return -1;
      }

      // Add the new question to the attempt
      List<QuizAttemptModel> updatedAttempts = List.from(existingQuiz.attempts);
      List<QuizQuestionModel> updatedQuestions = List.from(updatedAttempts[attemptIndex].questions)
        ..add(newQuestion);

      // Update attempt with new question list
      updatedAttempts[attemptIndex] = QuizAttemptModel(
        attemptId: updatedAttempts[attemptIndex].attemptId,
        quizId: updatedAttempts[attemptIndex].quizId,
        quizScore: updatedAttempts[attemptIndex].quizScore,
        attemptTimestamp: updatedAttempts[attemptIndex].attemptTimestamp,
        questions: updatedQuestions,
      );

      // Update quiz with new attempt list
      updatedQuizList[quizIndex] = QuizModel(
        quizId: existingQuiz.quizId,
        attempts: updatedAttempts,
      );

      // Update SQLite
      await db.update(
        'UserModel',
        {'quizList': jsonEncode(updatedQuizList.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('New quiz question inserted successfully');
      return updatedQuestions.length;
    } catch (e) {
      print('Error inserting quiz question: $e');
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

  Future<int> updateIsCorrect(String userId, int quizNumber, int questionIndex, bool isCorrect) async {
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

      // Find the quiz
      int quizIndex = user.quizList?.indexWhere((q) => q.quizId == 'quiz$quizNumber') ?? -1;
      if (quizIndex == -1) {
        print('Quiz not found');
        return -1;
      }

      // Find the latest attempt
      QuizModel existingQuiz = user.quizList![quizIndex];
      if (existingQuiz.attempts.isEmpty) {
        print('No attempts found.');
        return -1;
      }

      // Get latest attempt
      QuizAttemptModel latestAttempt = existingQuiz.attempts.last;

      // Find the question
      List<QuizQuestionModel> updatedQuestions = List.from(latestAttempt.questions);
      if (questionIndex < updatedQuestions.length) {
        updatedQuestions[questionIndex] = QuizQuestionModel(
          questionId: updatedQuestions[questionIndex].questionId,
          isCorrect: isCorrect,
          beginTimeStamp: updatedQuestions[questionIndex].beginTimeStamp,
          endTimeStamp: updatedQuestions[questionIndex].endTimeStamp,
          userAnswer: updatedQuestions[questionIndex].userAnswer,
        );
      }

      // Update attempt with modified question list
      List<QuizAttemptModel> updatedAttempts = List.from(existingQuiz.attempts);
      updatedAttempts[updatedAttempts.length - 1] = QuizAttemptModel(
        attemptId: latestAttempt.attemptId,
        quizId: latestAttempt.quizId,
        quizScore: latestAttempt.quizScore,
        attemptTimestamp: latestAttempt.attemptTimestamp,
        questions: updatedQuestions,
      );

      // Update quiz with modified attempt list
      user.quizList![quizIndex] = QuizModel(
        quizId: existingQuiz.quizId,
        attempts: updatedAttempts,
      );

      // Update SQLite
      int result = await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Updated isCorrect for questionIndex: $questionIndex in SQLite.');
      return result;
    } catch (e) {
      print('Error updating isCorrect in SQLite: $e');
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

  Future<int> updateBeginTimestamp(String userId, String questionId, String beginTimeStamp) async {
    try {
      final db = await database;

      // Fetch user data from UserModel
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found.');
        return -1;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Find the quiz that contains the latest attempt
      QuizModel? quiz = user.quizList?.lastWhere(
            (quiz) => quiz.attempts.isNotEmpty,
        orElse: () => QuizModel(quizId: 'unknown', attempts: []),
      );

      if (quiz == null || quiz.attempts.isEmpty) {
        print('No matching quiz attempt found.');
        return -1;
      }

      // Get the latest attempt
      QuizAttemptModel latestAttempt = quiz.attempts.last;

      // Find the question index
      int questionIndex = latestAttempt.questions.indexWhere((q) => q.questionId == questionId);

      if (questionIndex == -1) {
        print('No matching question found.');
        return -1;
      }

      // Create a new question object with updated begin timestamp
      QuizQuestionModel updatedQuestion = QuizQuestionModel(
        questionId: latestAttempt.questions[questionIndex].questionId,
        isCorrect: latestAttempt.questions[questionIndex].isCorrect,
        beginTimeStamp: DateTime.parse(beginTimeStamp), // Updated timestamp
        endTimeStamp: latestAttempt.questions[questionIndex].endTimeStamp,
        userAnswer: latestAttempt.questions[questionIndex].userAnswer,
      );

      // Replace the old question with the updated question
      latestAttempt.questions[questionIndex] = updatedQuestion;

      // Save updated data back to SQLite
      await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Begin timestamp updated successfully for latest attempt.');
      return 1;
    } catch (e) {
      print('Error updating begin timestamp: $e');
      return -1;
    }
  }

  Future<int> updateEndTimestamp(String userId, String questionId, String endTimeStamp) async {
    try {
      final db = await database;

      // Fetch user data from UserModel
      List<Map<String, dynamic>> userData = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userData.isEmpty) {
        print('User not found.');
        return -1;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Find the quiz that contains the latest attempt
      QuizModel? quiz = user.quizList?.lastWhere(
            (quiz) => quiz.attempts.isNotEmpty,
        orElse: () => QuizModel(quizId: 'unknown', attempts: []),
      );

      if (quiz == null || quiz.attempts.isEmpty) {
        print('No matching quiz attempt found.');
        return -1;
      }

      // Get the latest attempt
      QuizAttemptModel latestAttempt = quiz.attempts.last;

      // Find the question index
      int questionIndex = latestAttempt.questions.indexWhere((q) => q.questionId == questionId);

      if (questionIndex == -1) {
        print('No matching question found.');
        return -1;
      }

      // Create a new question object with updated end timestamp
      QuizQuestionModel updatedQuestion = QuizQuestionModel(
        questionId: latestAttempt.questions[questionIndex].questionId,
        isCorrect: latestAttempt.questions[questionIndex].isCorrect,
        beginTimeStamp: latestAttempt.questions[questionIndex].beginTimeStamp,
        endTimeStamp: DateTime.parse(endTimeStamp),
        userAnswer: latestAttempt.questions[questionIndex].userAnswer,
      );

      // Replace the old question with the updated question
      latestAttempt.questions[questionIndex] = updatedQuestion;

      // Save updated data back to SQLite
      await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList?.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('End timestamp updated successfully for latest attempt.');
      return 1;
    } catch (e) {
      print('Error updating end timestamp: $e');
      return -1;
    }
  }

  Future<void> updateUserAnswerSQLite(String userId, int quizNumber, String questionId, String userAnswer) async {
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
        return;
      }

      UserModel user = UserModel.fromJson(userData.first);

      // Find the quiz with the latest attempt
      QuizModel? quiz = user.quizList?.firstWhere(
            (q) => q.quizId == 'quiz$quizNumber',
        orElse: () => QuizModel(quizId: 'quiz$quizNumber', attempts: []),
      );

      if (quiz != null && quiz.attempts.isNotEmpty) {
        QuizAttemptModel latestAttempt = quiz.attempts.last;

        // Find the matching question
        int questionIndex = latestAttempt.questions.indexWhere((q) => q.questionId == questionId);

        if (questionIndex != -1) {
          // Create an updated question with the user's answer
          QuizQuestionModel updatedQuestion = QuizQuestionModel(
            questionId: latestAttempt.questions[questionIndex].questionId,
            isCorrect: latestAttempt.questions[questionIndex].isCorrect, // Keep existing correctness
            beginTimeStamp: latestAttempt.questions[questionIndex].beginTimeStamp,
            endTimeStamp: latestAttempt.questions[questionIndex].endTimeStamp,
            userAnswer: userAnswer,
          );

          // Replace the old question with the updated question
          latestAttempt.questions[questionIndex] = updatedQuestion;

          // Update the user model in SQLite
          await db.update(
            'UserModel',
            {'quizList': jsonEncode(user.quizList?.map((e) => e.toJson()).toList())},
            where: 'userId = ?',
            whereArgs: [userId],
          );

          print('User answer updated successfully in SQLite.');
        }
      }
    } catch (e) {
      print('Error updating user answer in SQLite: $e');
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

      int moduleIndex = lessonNumber;
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
      int moduleIndex = quizNumber;
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
        moduleProgress[i] = (completedTasks/2).toDouble();
      }

      print('Module progress fetched successfully: $moduleProgress');
      return moduleProgress;
    } catch (e) {
      print('Error fetching module progress: $e');
      return {};
    }
  }

  Future<List<List<bool>>> getModuleCompletionStatus(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'UserModel',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      String? completionData = result.first['ifEachModuleComplete'];

      if (completionData != null && completionData.isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(completionData);
          return decodedList.map((innerList) => List<bool>.from(innerList)).toList();
        } catch (e) {
          print('Error decoding module completion status: $e');
        }
      }
    }
    // Return an empty structure if no data is found
    return List.generate(6, (_) => List<bool>.filled(5, false));
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
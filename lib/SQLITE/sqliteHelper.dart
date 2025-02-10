import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/UserModel.dart';
import '../models/quizModel.dart';
import '../models/quizQuestionModel.dart';

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
        quizList TEXT,
        readingList TEXT,
        accessories TEXT,
        ifEachModuleComplete TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE QuizModel (
        quizId TEXT PRIMARY KEY,
        quizScore INTEGER,
        userId TEXT,
        FOREIGN KEY(userId) REFERENCES UserModel(userId)
      )
    ''');

    await db.execute('''
      CREATE TABLE QuizQuestionModel (
        questionId TEXT PRIMARY KEY,
        isCorrect BOOLEAN,
        beginTimeStamp TEXT,
        endTimeStamp TEXT,
        quizId TEXT,
        FOREIGN KEY(quizId) REFERENCES QuizModel(quizId)
      )
    ''');

    await db.execute('''
      CREATE TABLE ReadingModel (
        readingID TEXT PRIMARY KEY,
        progress INTEGER,
        userId TEXT,
        FOREIGN KEY(userId) REFERENCES UserModel(userId)
      )
    ''');
    print('Database schema created successfully.');
  }


  Future<int> insertUser(Map<String, dynamic> userData, String password) async {
    try {
      final db = await database;

      userData['quizList'] = jsonEncode(userData['quizList']);
      userData['readingList'] = jsonEncode(userData['readingList']);
      userData['accessories'] = jsonEncode(userData['accessories']);
      userData['ifEachModuleComplete'] = jsonEncode(userData['ifEachModuleComplete']);

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
      int result = await db.update(
        'ReadingModel',
        {'progress': progress},
        where: 'userId = ? AND readingID = ?',
        whereArgs: [userId, lessonNumber.toString()],
      );
      print('Reading progress updated successfully.');
      return result;
    } catch (e) {
      print('Error updating reading progress: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getReadingList(String userId) async {
    try {
      final db = await database;
      return await db.query(
        'ReadingModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );
    } catch (e) {
      print('Error fetching reading list: $e');
      return [];
    }
  }

  Future<int> updateQuizScore(String userId, int quizNumber, int quizResult) async {
    try {
      final db = await database;
      int result = await db.update(
        'QuizModel',
        {'quizScore': quizResult},
        where: 'userId = ? AND quizId = ?',
        whereArgs: [userId, quizNumber.toString()],
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

  Future<int> updateEndTimestamp(String userId, String questionId, String endTimeStamp) async {
    try {
      final db = await database;

      List<Map<String, dynamic>> userRecords = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userRecords.isEmpty) {
        print('User not found.');
        return -1;
      }

      UserModel user = UserModel.fromJson(userRecords.first);

      QuizModel? targetQuiz;
      for (QuizModel quiz in user.quizList ?? []) {
        if (quiz.questions.any((q) => q.questionId == questionId)) {
          targetQuiz = quiz;
          break;
        }
      }

      if (targetQuiz == null) {
        print('Quiz containing the question not found.');
        return -1;
      }

      List<QuizQuestionModel> updatedQuestions = targetQuiz.questions.map((q) {
        if (q.questionId == questionId) {
          return QuizQuestionModel(
            questionId: q.questionId,
            isCorrect: q.isCorrect,
            beginTimeStamp: q.beginTimeStamp,
            endTimeStamp: DateTime.parse(endTimeStamp),
          );
        }
        return q;
      }).toList();

      QuizModel updatedQuiz = QuizModel(
        quizId: targetQuiz.quizId,
        quizScore: targetQuiz.quizScore,
        questions: updatedQuestions,
      );

      List<QuizModel> updatedQuizList = user.quizList!.map((quiz) {
        return quiz.quizId == updatedQuiz.quizId ? updatedQuiz : quiz;
      }).toList();

      user.quizList = updatedQuizList;

      int result = await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList!.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('End timestamp updated successfully.');
      return result;
    } catch (e) {
      print('Error updating end timestamp: $e');
      return -1;
    }
  }

  Future<int> updateBeginTimestamp(String userId, String questionId, String beginTimeStamp) async {
    try {
      final db = await database;

      List<Map<String, dynamic>> userRecords = await db.query(
        'UserModel',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      if (userRecords.isEmpty) {
        print('User not found.');
        return -1;
      }

      print('Retrieved user record: ${userRecords.first}');

      UserModel user;
      try {
        user = UserModel.fromJson(userRecords.first);
      } catch (e) {
        print('Error in UserModel.fromJson: $e');
        return -1;
      }

      print('Parsed UserModel:');
      print('Email: ${user.email}');
      print('UserId: ${user.userId}');
      print('DeviceToken: ${user.deviceToken}');
      print('ProfilePic: ${user.profilePic}');
      print('BannerImage: ${user.bannerImage}');
      print('NumTickets: ${user.numTickets}');
      print('QuizList: ${user.quizList}');
      print('ReadingList: ${user.readingList}');
      print('Accessories: ${user.accessories}');
      print('IfEachModuleComplete: ${user.ifEachModuleComplete}');

      QuizModel? targetQuiz;
      for (QuizModel quiz in user.quizList ?? []) {
        if (quiz.questions.any((q) => q.questionId == questionId)) {
          targetQuiz = quiz;
          break;
        }
      }

      if (targetQuiz == null) {
        print('Quiz containing the question not found.');
        return -1;
      }

      List<QuizQuestionModel> updatedQuestions = targetQuiz.questions.map((q) {
        if (q.questionId == questionId) {
          return QuizQuestionModel(
            questionId: q.questionId,
            isCorrect: q.isCorrect,
            beginTimeStamp: DateTime.parse(beginTimeStamp),
            endTimeStamp: q.endTimeStamp,
          );
        }
        return q;
      }).toList();

      QuizModel updatedQuiz = QuizModel(
        quizId: targetQuiz.quizId,
        quizScore: targetQuiz.quizScore,
        questions: updatedQuestions,
      );

      List<QuizModel> updatedQuizList = user.quizList!.map((quiz) {
        return quiz.quizId == updatedQuiz.quizId ? updatedQuiz : quiz;
      }).toList();

      user.quizList = updatedQuizList;

      int result = await db.update(
        'UserModel',
        {'quizList': jsonEncode(user.quizList!.map((e) => e.toJson()).toList())},
        where: 'userId = ?',
        whereArgs: [userId],
      );

      print('Begin timestamp updated successfully.');
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
}
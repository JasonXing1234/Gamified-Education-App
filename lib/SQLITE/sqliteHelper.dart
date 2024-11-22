import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    return await openDatabase(
      path,
      version: 2, // Increment the version to force an upgrade
      onCreate: _onCreate,// Add this line
    );
  }

  Future<void> _onCreate(Database db, int version) async {
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
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add missing columns if upgrading from version 1 to 2
      await db.execute("ALTER TABLE UserModel ADD COLUMN quizList TEXT");
      await db.execute("ALTER TABLE UserModel ADD COLUMN readingList TEXT");
      await db.execute("ALTER TABLE UserModel ADD COLUMN accessories TEXT");
      await db.execute("ALTER TABLE UserModel ADD COLUMN ifEachModuleComplete TEXT");
    }
  }

  Future<int> insertUser(Map<String, dynamic> userData) async {
    final db = await database;

    // Convert list fields to JSON strings
    userData['quizList'] = jsonEncode(userData['quizList']);
    userData['readingList'] = jsonEncode(userData['readingList']);
    userData['accessories'] = jsonEncode(userData['accessories']);
    userData['ifEachModuleComplete'] = jsonEncode(userData['ifEachModuleComplete']);

    return await db.insert(
      'UserModel',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'UserModel',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      maps[0]['accessories'] = jsonDecode(maps[0]['accessories']);
      maps[0]['ifEachModuleComplete'] = jsonDecode(maps[0]['ifEachModuleComplete']);
      return maps[0];
    }
    return null;
  }
}
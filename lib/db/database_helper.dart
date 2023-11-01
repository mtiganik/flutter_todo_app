import 'package:flutter_todo_app/db/initial_db_values.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "todo_database3.db";
  static const _databaseVersion = 1;
  static Database? _database;

  // Singleton pattern for database access
  static DatabaseHelper? _instance;

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  DatabaseHelper._internal();

  // Initialize the database
  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return openDatabase(path, onCreate: _onCreate, version: _databaseVersion);
  }

  Future<void> _onCreate(Database db, int version) async {
    print("Start of onCreate");
    await db.execute(
      '''CREATE TABLE User(id INTEGER PRIMARY KEY, token TEXT, refreshToken TEXT, firstName TEXT, lastName TEXT)'''
    );
    await db.execute(
      '''CREATE TABLE Category(id TEXT PRIMARY KEY, categoryName TEXT, categorySort INTEGER, syncDt TEXT)'''
    );
    await db.execute(
        '''CREATE TABLE Priority(id TEXT PRIMARY KEY, priorityName TEXT, prioritySort INTEGER, syncDt TEXT)''');

    await db.execute(
        '''CREATE TABLE Task(id TEXT PRIMARY KEY, taskName TEXT, taskSort INTEGER, createdDt TEXT, 
        dueDt TEXT, isCompleted BOOLEAN, syncDt TEXT, isArchived BOOLEAN, todoCategoryId TEXT, todoPriorityId TEXT, 
        FOREIGN KEY(todoCategoryId) REFERENCES Category(id), FOREIGN KEY(todoPriorityId) REFERENCES Priority(id))''');
    // await db.execute(
    //     '''CREATE TABLE Task(id TEXT PRIMARY KEY, taskName TEXT, taskSort INTEGER, createdDt INTEGER, dueDt INTEGER, isCompleted BOOLEAN, isArchived BOOLEAN, todoCategoryId TEXT, todoPriorityId TEXT)''');

    // await InitialDbValues.addCategories();
    // await InitialDbValues.addPriorities();
    // await InitialDbValues.addTask();
    print("End of onCreate");
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<void> deleteDb() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, _databaseName);
  await deleteDatabase(path);
}

  Future<List<String>?> getAllTableNames() async {
    final db = await database;
    final result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    if (result.isNotEmpty) {
      return result.map((row) => row['name'] as String).toList();
    }
    return null; // No tables found
  }


}

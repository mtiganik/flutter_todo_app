import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "todo_database.db";
  static const _databaseVersion = 2;
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
      '''CREATE TABLE Category(id TEXT PRIMARY KEY, categoryName TEXT, categorySort INTEGER, syncDt INTEGER)'''
    );
    await db.execute(
        '''CREATE TABLE Priority(id TEXT PRIMARY KEY, priorityName TEXT, prioritySort INTEGER, syncDt INTEGER)''');
    await db.execute(
        '''CREATE TABLE Task(id TEXT PRIMARY KEY, taskName TEXT, taskSort INTEGER, createdDt INTEGER, dueDt INTEGER, 
  isCompleted BOOLEAN, isArchived BOOLEAN, FOREIGN KEY(todoCategoryId) REFERENCES Category(id), FOREIGN KEY(todoPriorityId) REFERENCES Priority(id)''');
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

}

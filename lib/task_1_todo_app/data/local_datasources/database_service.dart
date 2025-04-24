import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final int version = 1;

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'todo_app.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    // The version is an integer and can be used to manage database migrations.
    // The onCreate function is called the first time the database is created.

    final database = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
      onDowngrade: _onDowngrade,
    );

    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    //  Create the tables in the database
    await db.execute('''
      CREATE TABLE IF NOT EXISTS todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        is_completed INTEGER NOT NULL DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    // This is where you can add new tables or modify existing ones
    // based on the version number.
    // For example, if you want to add a new column to the todo table:
    if (oldVersion < newVersion) {}
  }

  Future<void> _onConfigure(Database db) async {
    // Enable foreign key constraints
    // This is important for maintaining data integrity
    // when using foreign keys in your database schema.
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    // Handle database downgrades here
    // This is where you can remove tables or modify existing ones
    // based on the version number.
    // For example, if you want to drop a table:
    if (oldVersion > newVersion) {
      await db.execute('DROP TABLE IF EXISTS todo');
    }
  }
}

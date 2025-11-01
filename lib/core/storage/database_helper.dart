import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;
  static final _instance = DatabaseHelper._();
  DatabaseHelper._();
  factory DatabaseHelper() => _instance;

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          
CREATE TABLE users (
            id TEXT PRIMARY KEY,
            email TEXT UNIQUE,
            name TEXT
            
          )
          
        ''');
      },
    );
  }

  /// Asynchronously gets the database instance.
  /// Initializes the database if it hasn't been already.
  Future<Database> getDb() async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }
}

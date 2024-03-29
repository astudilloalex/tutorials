import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// ignore: avoid_classes_with_only_static_members
class SQLite {
  static late Database _db;

  static Future<void> _onCreate(Database db, int ver) async {
    await db.execute(
      "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)",
    );
  }

  static Future<void> init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Database get db => _db;
}

class SQLiteHelper {
  Future<List<Map<String, dynamic>>> get notes async {
    return SQLite.db.query(
      'notes',
      orderBy: 'id DESC',
    );
  }

  Future<int> insertNote(Map<String, dynamic> note) async {
    return SQLite.db.insert(
      'notes',
      note,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteNote(int id) async {
    return SQLite.db.delete(
      'notes',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}

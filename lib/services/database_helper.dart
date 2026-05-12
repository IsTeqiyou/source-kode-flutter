import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  // ================= SINGLETON =================
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // ================= GET DATABASE =================
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  // ================= INIT DATABASE =================
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // ================= CREATE TABLE =================
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        author TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  // ================= CREATE =================
  Future<int> insertNote(Note note) async {
    final db = await instance.database;

    return await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ================= READ =================
  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;

    final result = await db.query('notes', orderBy: 'created_at DESC');

    return result.map((json) => Note.fromMap(json)).toList();
  }

  // ================= UPDATE =================
  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // ================= DELETE =================
  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // ================= DELETE ALL (OPSIONAL) =================
  Future<int> deleteAllNotes() async {
    final db = await instance.database;
    return await db.delete('notes');
  }

  // ================= CLOSE =================
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:sqflite/sqlite_api.dart';
import 'package:note_app/models/note_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'note';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnNote = 'note';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //Cek database existing
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'note.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnTitle TEXT,"
        "$columnNote TEXT)";

    await db.execute(sql);
  }

  //get data
  Future<List?> getAllNote() async {
    var dbClient = await _db;

    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNote,
      columnTitle,
    ]);

    return result.toList();
  }

  //save data
  Future<int?> saveNote(NoteModel note) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, note.toMap());
  }

  //Update data
  Future<int?> updateNote(NoteModel note) async {
    var dbClient = await _db;

    return await dbClient!.update(tableName, note.toMap(),
        where: '$columnId = ?', whereArgs: [note.id]);
  }

  //Delete data
  Future<int?> deleteNote(int id) async {
    var dbClient = await _db;

    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  //Get Note by ID
  Future<dynamic> getNoteById(int id) async {
    var dbClient = await _db;

    var result = await dbClient!.query(tableName,
        columns: [
          columnId,
          columnNote,
          columnTitle,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);

    return result;
  }
}

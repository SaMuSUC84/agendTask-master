import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        priority INTEGER NOT NULL,
        dueDate TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await instance.database;

    int result = await db.insert('tasks', task);

    print("Tarea insertada: $task, ID: $result"); // <-- Debug log

    return result;
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;

    // Consulta filtrada por fecha sin finalizar.
    final List<Map<String, dynamic>> result = await db.query('tasks',
        where: 'dueDate > ?',
        whereArgs: [DateTime.now().toIso8601String()],
        orderBy: 'dueDate ASC');

    print("Tareas recuperadas desde la BD: $result"); // Debug log

    return result;
  }

  Future<List<Map<String, dynamic>>> getEndTasks() async {
    final db = await instance.database;

    // Consulta filtrada por fecha finalizada.
    final List<Map<String, dynamic>> result = await db.query('tasks',
        where: 'dueDate < ?',
        whereArgs: [DateTime.now().toIso8601String()],
        orderBy: 'dueDate DESC');

    print("Tareas recuperadas desde la BD: $result"); // Debug log

    return result;
  }
}

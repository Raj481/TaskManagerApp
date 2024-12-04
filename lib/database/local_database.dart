import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task_model.dart';

class LocalDatabase {
  static Database? _database;

//  create table
  static Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  // database initialize
  static Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  // Add data

  static Future<void> addTask(TaskModel task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  // Delete Data
  static Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

// Update data
  static Future<void> updateTask(TaskModel task) async {
    final db = await database;
    var isUpdated = await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    print("is updated :::: ${isUpdated}");
  }

// get data database table
  static Future<List<Map<String, dynamic>>> getTaskData() async {
    final db = await database;
    var data = await db.rawQuery("select * from tasks");
    print(">>>>");
    print(data);

    return data;
  }
}

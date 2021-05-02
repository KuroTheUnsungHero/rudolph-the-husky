import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/model/task.dart';

// database table and column names
final String tableTasks = 'tasks';
final String columnId = '_id';
final String columnTaskName = 'title';
final String columnCreatedDate = 'created_date';
final String columnDescription = 'description';
final String columnStatus = 'status';

    // singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "tasks.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableTasks (
            $columnId INTEGER PRIMARY KEY,
            $columnTaskName TEXT NOT NULL,
            $columnDescription TEXT,
            $columnCreatedDate TEXT NOT NULL,
            $columnStatus INTEGER NOT NULL
          )
          ''');
  }

  // Database helper methods:

  Future<int> insert(Task task) async {
    Database db = await database;
    int id = await db.insert(tableTasks, task.toMap());
    return id;
  }

  Future<List<Task>> queryTask() async {
    List<Task> tasks = [];
    Database db = await database;
    List<Map> maps = await db.query(tableTasks,
        columns: [columnId, columnTaskName, columnDescription, columnCreatedDate, columnStatus],
      );

    for (int i = 0; i < maps.length; i++) {
      Task taskToAdd = Task.fromMap(maps[i]);

      if (!taskToAdd.isDone) {
        tasks.add(taskToAdd);
      }
      
    }

    return tasks;
  }

  Future<List<Task>> queryCompletedTask() async {
    List<Task> tasks = [];
    Database db = await database;
    List<Map> maps = await db.query(tableTasks,
        columns: [columnId, columnTaskName, columnDescription, columnCreatedDate, columnStatus],
      );

    for (int i = 0; i < maps.length; i++) {
      Task taskToAdd = Task.fromMap(maps[i]);

      if (taskToAdd.isDone) {
        tasks.add(taskToAdd);
      }
      
    }

    return tasks;
  }

  Future<int> update(Task task) async {
    Database db = await database;

    Map<String, dynamic> row = {
      columnTaskName: task.title,
      columnDescription: task.description,
      columnStatus: task.isDone ? '1':'0'
    };

    int updateCount = await db.update(
        tableTasks,
        row,
        where: '$columnId = ?',
        whereArgs: [task.id]);

    return updateCount;
  }

  Future<int> delete(Task task) async {
    Database db = await database;

    int deleteCount = await db.delete(
        tableTasks,
        where: '$columnId = ?',
        whereArgs: [task.id]);

    return deleteCount;
  }
}
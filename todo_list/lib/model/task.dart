import 'package:flutter/cupertino.dart';

class TaskField {
  static const createdTime = 'createdTime';
}

// database table and column names
final String tableTasks = 'tasks';
final String columnId = '_id';
final String columnTaskName = 'title';
final String columnCreatedDate = 'created_date';
final String columnDescription = 'description';
final String columnStatus = 'status';

class Task {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Task({
    @required this.createdTime,
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
  });

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId].toString();
    title = map[columnTaskName];
    description = map[columnDescription];
    createdTime = DateTime.parse(map[columnCreatedDate]);
    if (map[columnStatus] == 0) {
      isDone = false;
    } else {
      isDone = true;
    }
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTaskName: title,
      columnDescription: description,
      columnCreatedDate: createdTime.toString(),
      columnStatus: isDone ? '1':'0',
    };

    if (id != null) {
      map[columnId] = int.parse(id);
    }

    return map;
  }
}
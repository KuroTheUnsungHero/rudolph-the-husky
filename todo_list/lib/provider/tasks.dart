import 'package:flutter/cupertino.dart';
import 'package:todo_list/database/database_helper.dart';
import 'package:todo_list/model/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  
  void getDataFromDb() async {
    _tasks = await DatabaseHelper.instance.queryTask();
  }
  
  //getter non completed
  List<Task> get tasks => _tasks.where((task) => task.isDone == false).toList();

  //getter completed
  List<Task> get taskCompleted => _tasks.where((task) => task.isDone == true).toList();

  void addTask(Task task) {
    _tasks.add(task);
    DatabaseHelper.instance.insert(task);

    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    DatabaseHelper.instance.delete(task);

    notifyListeners();
  }

  bool toggleTaskStatus(Task task) {
    task.isDone = !task.isDone;
    DatabaseHelper.instance.update(task);

    notifyListeners();

    return task.isDone;
  }

  void updateTask(Task task, String title, String description) {
    task.title = title;
    task.description = description;
    DatabaseHelper.instance.update(task);

    notifyListeners();
  }
}
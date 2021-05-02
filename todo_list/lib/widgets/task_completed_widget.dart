import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database_helper.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/tasks.dart';
import 'package:todo_list/widgets/task_widget.dart';

class TaskCompletedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: DatabaseHelper.instance.queryCompletedTask(),
    builder: (context, AsyncSnapshot<List<Task>> snapshot) {
      if (snapshot.hasData) {
        return Center( child: buildContainer(context, snapshot.data));
      }else
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
  
  Widget buildContainer(BuildContext context, List<Task> tasks) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              'No tasks.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated( //eto yung list nung data separated
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8), //space nung pagka hiwalay
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return TaskWidget(task: task);
            },
          );
  }
}
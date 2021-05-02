import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database_helper.dart';
import 'package:todo_list/model/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/pages/edit_page.dart';
import 'package:todo_list/provider/tasks.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  void _showToast(String str) {
    Fluttertoast.showToast(  
        msg: str,  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,  
        timeInSecForIos: 1,  
        backgroundColor: Colors.black,  
        textColor: Colors.white  
    );  
  }

  void _deleteTask(BuildContext context, Task task) async {
    DatabaseHelper.instance.delete(task);

    _showToast('Deleted the task');
  }

  void _editTask(BuildContext context, Task task) async {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTaskPage(task: task),
        ),
      );
  }

  void _markCompleted(BuildContext context, Task task) async {
    task.isDone = !task.isDone;
    DatabaseHelper.instance.update(task);

    if (task.isDone) {
      _showToast('Task Completed');
    } else {
      _showToast('Task Incomplete');
    }
  }
  
  const TaskWidget({
    @required this.task,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(task.id),
          //slide to right
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => _editTask(context, task),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          //slide to left
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => _deleteTask(context, task),
              icon: Icons.delete,
            )
          ],
          child: buildTodo(context),
        );

  //yung container is parang div in web
  Widget buildTodo(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: task.isDone,
              onChanged: (_) {_markCompleted(context, task);},
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (task.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        task.description,
                        style: TextStyle(fontSize: 20, height: 1.5),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
}
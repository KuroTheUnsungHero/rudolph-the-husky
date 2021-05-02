import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database_helper.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/tasks.dart';
import 'package:todo_list/widgets/task_form_widget.dart';

class AddTaskDialogWidget extends StatefulWidget {
  @override
  _AddTaskDialogWidgetState createState() => _AddTaskDialogWidgetState();
}

class _AddTaskDialogWidgetState extends State<AddTaskDialogWidget> {
  final formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  void _changeTitle(String title) {
    setState(() {
      this.title = title;
    });
  }

  void _changeDescription(String description) {
    setState(() {
      this.description = description;
    });
  }

  void _addTask() async {
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
       final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
        isDone: false,
      );

      DatabaseHelper.instance.insert(task);

      Navigator.of(context).pop();
    }
  }

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

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Form (
      key: formKey,
      child: Column(
      mainAxisSize: MainAxisSize.min, 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22
          )
        ),
        const SizedBox(height: 8),
        
        TaskFormWidget(
          onChangedTitle: (title) => _changeTitle(title),
          onChangedDescription: (description) => _changeDescription(description),
          onSavedTask: _addTask,
        ),
      ],),
    ),
  );
}
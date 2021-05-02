import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/database/database_helper.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider/tasks.dart';
import 'package:todo_list/widgets/task_form_widget.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final formKey = GlobalKey<FormState>();

  String title;
  String description;

  void _saveTask() {
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TasksProvider>(context, listen: false);

      provider.updateTask(widget.task, title, description);

      Navigator.of(context).pop();
    }
  }

  void _deleteTask(BuildContext context, Task task) {
    DatabaseHelper.instance.update(task);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    title = widget.task.title;
    description = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTask(context, widget.task),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TaskFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) => setState(() => this.description = description),
            onSavedTask: () => _saveTask(),
          ),
        ),
      ),
    );
  }
}
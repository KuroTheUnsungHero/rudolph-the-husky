import 'package:flutter/material.dart';
import 'package:todo_list/database/database_helper.dart';
import 'package:todo_list/provider/tasks.dart';
import 'package:todo_list/widgets/add_task_dialog.dart';
import "package:provider/provider.dart";
import 'package:todo_list/widgets/task_completed_widget.dart';
import 'package:todo_list/widgets/task_list_widget.dart';

import 'model/task.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        title: 'To Do List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'To Do List Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  int selectedIndex = 0;
  List<Task> tasks = [];
  bool isLoading = false;

  //Dito yung mga functions
  void _changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshTasks();
  }

  Future refreshTasks() async {
    setState(() => isLoading = true);

    this.tasks = await DatabaseHelper.instance.queryTask();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    final tabs = [
      TaskListWidget(),
      TaskCompletedWidget(),
    ];

    //return yung itsura
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white, 
        currentIndex: selectedIndex,
        items: [
          //laman nung bot nav bar
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed',
          ),
        ],
        onTap: (index) => _changeTab(index),
        ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          child: AddTaskDialogWidget(),
          ).then((value) => refreshTasks()),
        tooltip: 'Add task',
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}

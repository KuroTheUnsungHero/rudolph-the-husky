import 'package:anime_search/widgets/anime_browse_widget.dart';
import 'package:anime_search/widgets/anime_list_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Search',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Anime Search'),
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

  int selectedIndex = 0;

  final tabs = [
    AnimeListWidget(),
    AnimeBrowseWidget(),
  ];

  void _changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.sentiment_very_satisfied_outlined),
            label: 'Top Anime',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
        ],
        onTap: (index) => _changeTab(index),
      ),
      body: tabs[selectedIndex],
      backgroundColor: Colors.black38,
    );
  }
}

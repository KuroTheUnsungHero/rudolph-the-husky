import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'browse_widget.dart';

class AnimeBrowseWidget extends StatefulWidget {
  
  @override
  _AnimeBrowseWidgetState createState() => _AnimeBrowseWidgetState();
}

class _AnimeBrowseWidgetState extends State<AnimeBrowseWidget> {
  var jikan = Jikan();
  String searchString = 'the';

  void _changeSearchQuery(String searchQuery) {
    if (searchQuery.length >= 3) {
      setState(() {
        this.searchString = searchQuery;
      });
    } else if (searchQuery.length == 0) {
      setState(() {
        this.searchString = 'the';
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: jikan.search(searchString, SearchType.anime),
    builder: (context, AsyncSnapshot<BuiltList<Search>> snapshot) {
      if (snapshot.hasData) {
        return Center(
          child: buildContainer(context, snapshot.data.toList())
        );
      } else
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget buildContainer(BuildContext context, List<Search> search) {
    return search.isEmpty
    ? Center(
        child: Text(
          'No anime.',
          style: TextStyle(fontSize: 20),
        ),
      )
    : Container(
      child: new Column(
        children: [
          buildSearchBar(),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(1),
              separatorBuilder: (context, index) => Container(height: 2), 
              itemCount: search.length,
              itemBuilder: (context, index) {
                return BrowseWidget(search: search[index]);
              },
            ),
          )
        ],
      )
    );
  }

  Widget buildSearchBar() {
    return Container (
      color: Colors.white,
      padding: const EdgeInsets.all(3),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: 'Search'
        ),
        onChanged: (text) => _changeSearchQuery(text),
      ),
    );
  }
}
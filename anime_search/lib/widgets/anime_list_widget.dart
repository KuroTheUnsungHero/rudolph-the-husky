import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

import 'anime_widget.dart';

class AnimeListWidget extends StatelessWidget {
  
  var jikan = Jikan();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: jikan.getTop(TopType.anime, subtype: TopSubtype.airing),
    builder: (context, AsyncSnapshot<BuiltList<Top>> snapshot) {
      if (snapshot.hasData) {
        return Center( child: buildContainer(context, snapshot.data.toList()));
      } else
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
  
  Widget buildContainer(BuildContext context, List<Top> top) {
    return top.isEmpty
        ? Center(
            child: Text(
              'No anime.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(2),
            separatorBuilder: (context, index) => Container(height: 2), 
            itemCount: top.length,
            itemBuilder: (context, index) {
              final anime = top[index];
              return AnimeWidget(top: anime);
            },
          );
  }
}
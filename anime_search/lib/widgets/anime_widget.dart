import 'package:anime_search/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeWidget extends StatelessWidget {
  final Top top;

  String _getSubDescription(Top top) {
    String episodesUndefined = 'Not yet defined';
    String episodeCount = top.episodes == null ? episodesUndefined:top.episodes.toString();
    return 'Score: ' + top.score.toString() + ', Episodes: ' + episodeCount + ', Anime Type: ' + top.type;
  }

  void _getAnimeDetails(BuildContext context, int animeId) async {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(animeId: animeId),
        ),
      );
  }
  
  const AnimeWidget({
    @required this.top,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.grey,
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Expanded(
          child: ListTile(
            leading: Image.network(top.imageUrl),
            title: Text(top.title),
            subtitle: Text(_getSubDescription(top)),
            onTap: () => _getAnimeDetails(context, top.malId),
          ),
        ),
      ],
    ),
  );
}
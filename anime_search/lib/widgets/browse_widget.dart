import 'package:anime_search/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class BrowseWidget extends StatelessWidget {
  final Search search;

  String _getSubDescription(Search search) {
    String episodesUndefined = 'Not yet defined';
    String episodeCount = search.episodes == null ? episodesUndefined:search.episodes.toString();
    return 'Score: ' + search.score.toString() + ', Episodes: ' + episodeCount + ', Anime Type: ' + search.type;
  }

  void _getAnimeDetails(BuildContext context, int animeId) async {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(animeId: animeId),
        ),
      );
  }
  
  const BrowseWidget({
    @required this.search,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.grey,
    padding: EdgeInsets.all(2),
    child: Row(
      children: [
        Expanded(
          child: ListTile(
            leading: Image.network(search.imageUrl),
            title: Text(search.title),
            subtitle: Text(_getSubDescription(search)),
            onTap: () => _getAnimeDetails(context, search.malId),
          ),
        ),
      ],
    ),
  );
}
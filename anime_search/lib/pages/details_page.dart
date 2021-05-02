import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  final int animeId;

  const DetailsPage({Key key, @required this.animeId}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var jikan = Jikan();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: jikan.getAnimeInfo(widget.animeId),
    builder: (context, AsyncSnapshot<Anime> snapshot) {
      if (snapshot.hasData) {
        return Center( child: buildContainer(context, snapshot.data));
      } else
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget buildContainer(BuildContext context, Anime anime) {
    return Container(
      child: SingleChildScrollView (
        child: new Column(
          children: [
            buildImage(anime.imageUrl),
            buildPromotionalVids(anime.trailerUrl),
            buildDetails(anime.title, anime.titleJapanese, anime.type, anime.status, anime.synopsis),
          ],
        )
      )
    );
  }

  Widget buildImage(String url) {
    return Container (
      color: Colors.white70,
      padding: const EdgeInsets.all(3),
      child: Center(
        child: Column(
          children: [Image.network(url)],
        ),
      ),
    );
  }

  Widget buildDetails(String title, String titleJapanese, String type, String status, String synopsis) {
    return Container (
      color: Colors.grey,
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          
        ),
        child: Column(
          children: [
            Text(
              'Title: ' + title,
              style: TextStyle(height: 3, fontSize: 14, color: Colors.black, decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
            Text(
              'Japanese Title: ' + titleJapanese,
              style: TextStyle(height: 3, fontSize: 14, color: Colors.black, decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
            Text(
              'Type: ' + type,
              style: TextStyle(height: 3, fontSize: 14, color: Colors.black, decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
            Text(
              'Status: ' + status,
              style: TextStyle(height: 3, fontSize: 14, color: Colors.black, decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
            Text(
              'Synopsis: ' + synopsis,
              style: TextStyle(height: 3, fontSize: 14, color: Colors.black, decoration: TextDecoration.none),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPromotionalVids(String url) {
    return Container (
      color: Colors.grey,
      padding: const EdgeInsets.all(3),
      child: Center(
        child: Column(
          children: [
            Container (
              width: MediaQuery.of(context).size.width,
              color: Colors.white70,
              child: Text(
                'Promotional Video',
                style: TextStyle(height: 3, fontSize: 14, color: Colors.black, decoration: TextDecoration.none)
              ),
            ), 
            YoutubePlayer(
              controller: YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(url),
                    flags: YoutubePlayerFlags(
                        autoPlay: true,
                        mute: true,
                    ),
                ),
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/Network.dart';
import 'MediaImage.dart';
import 'MediaVideo.dart';

Network api = new Network();

class Movie extends Media{
  final String revenue, budget;
  Movie({
    String id,
    this.revenue,
    this.budget,
    String posterurl,
    String title,
    String overview,
    String releasedate,
    String runtime,
    String voteavg,
    String votecount,
    String imdbID,
    String status,
    String backdropurl,
    List<String> genres,
    List<Person> cast,
    List<Person> crew,
    List<MediaImage> posters,
    backdrops,
    List<MediaVideo> videos,
  }) : super(
          id: id,
          posterurl: posterurl,
          imdbID: imdbID,
          overview: overview,
          releasedate: releasedate,
          title: title,
          runtime: runtime,
          votecount: votecount,
          voteavg: voteavg,
          genres: genres,
          cast: cast,
          crew: crew,
          status: status,
          backdrops: backdrops,
          posters: posters,
          videos: videos,
          backdropurl: backdropurl,
        ) {
    super.mediaType = 'movie';
  }
}

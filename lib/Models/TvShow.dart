import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/Models/Season.dart';
import 'package:movie_app/Network.dart';

Network api = new Network();

class TvShow extends Media {
  String numberofepisodes, numberofseasons;
  List<Season> seasons;
  TvShow({
    String id,
    String posterurl,
    String title,
    String overview,
    String releasedate,
    String runtime,
    String voteavg,
    String votecount,
    String imdbID,
    String status,
    this.numberofepisodes,
    this.numberofseasons,
    String backdropurl,
    List<MediaImage> posters,
    backdrops,
    List<MediaVideo> videos,
    List<String> genres,
    List<Person> cast,
    List<Person> crew,
    this.seasons,
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
    super.mediaType = 'tv';
  }
}

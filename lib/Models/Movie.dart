import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/Person..dart';

class Movie extends Media {
  Movie({
    @required String id,
    String posterurl,
    String title,
    String overview,
    String releasedate,
    String runtime,
    String voteavg,
    String votecount,
    String imdbID,
    String status,
    List<String> genres,
    List<Person> cast,
    List<Person> crew,
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
        ) {
    mediaType = 'movie';
  }
  @override
  String toString() {
    return 'movie';
  }
}

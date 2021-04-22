import 'package:flutter/cupertino.dart';

import 'Person..dart';

class Media {
  String id,
      title,
      posterurl,
      overview,
      releasedate,
      runtime,
      votecount,
      voteavg,
      status,
      budget,
      revenue,
      mediaType,
      imdbID;
  List<String> genres;
  List<Person> cast;
  List<Person> crew;
  Media({
    @required this.id,
    this.posterurl,
    this.status,
    this.title,
    this.budget,
    this.revenue,
    this.genres,
    this.overview,
    this.releasedate,
    this.runtime,
    this.voteavg,
    this.votecount,
    this.imdbID,
    this.cast,
    this.crew,
  });
  void getGenres() {}
  void getCredits() {}
  void getReviews() {}
  void getRecommendations() {}
  void getSimilar() {}
  void getImages() {}
  void getVideos() {}
  void getDetails() {}
}

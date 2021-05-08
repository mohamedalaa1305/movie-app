import 'package:flutter/cupertino.dart';
import 'package:movie_app/Helper.dart';
import 'package:tuple/tuple.dart';

import 'Media.dart';
import 'MediaImage.dart';

class Person extends Media {
  String birthday,
      biography,
      id,
      profileImgUrl,
      placeOfBirth,
      imdbID,
      name,
      character,
      job,
      knownFor,
      mediaType;
  List<MediaImage> images;
  List<Tuple2<Media, String>> credits, movies, shows;

  Person({
    @required this.id,
    this.name,
    this.imdbID,
    this.biography,
    this.birthday,
    this.profileImgUrl,
    this.knownFor,
    this.placeOfBirth,
    this.character,
    this.job,
  }) : super(id: id) {
    super.mediaType = 'person';
  }
  @override
  Future<void> getImages() async {
    var response = await api.getPersonImages(id);
    // print("fetching profile Images");
    this.images = [];
    this.images = fetchImages(response, 'profiles');
  }

  @override
  Future<void> getCredits() async {
    var response = await api.getPersonCredits(id);
    this.credits = [];
    this.movies = [];
    this.shows = [];
    // print("fetching from api");
    this.credits = fetchPersonCredits(response);
    // print("credits len = " + credits.length.toString());
    for (var pair in credits) {
      // print("mediaType = " + pair.item1.mediaType);
      if (pair.item1.mediaType == 'movie')
        movies.add(pair);
      else
        shows.add(pair);
    }
    // print("movies len = " + movies.length.toString());
    // print("shows len = " + shows.length.toString());
  }
}

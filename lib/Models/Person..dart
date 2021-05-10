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
  Person.clone(Person p) {
    this.birthday = p.birthday;
    this.biography = p.biography;
    this.id = p.id;
    this.profileImgUrl = p.profileImgUrl;
    this.placeOfBirth = p.placeOfBirth;
    this.imdbID = p.imdbID;
    this.name = p.name;
    this.character = p.character;
    this.job = p.job;
    this.knownFor = p.knownFor;
    this.mediaType = p.mediaType;
  }
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
    this.credits = fetchPersonCredits(response);
    List<Tuple2<Media, String>> tmp1 = [];
    List<Tuple2<Media, String>> tmp2 = [];
    for (var pair in credits) {
      if (pair.item1.mediaType == 'movie')
        tmp1.add(pair);
      else
        tmp2.add(pair);
    }
    movies = removeDuplicates2(tmp1);
    shows = removeDuplicates2(tmp2);
  }
}

import 'package:flutter/cupertino.dart';

import 'Media.dart';

class Person extends Media{
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
  }):super(id: id) {
    super.mediaType = 'person';
  }
}

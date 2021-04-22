import 'package:flutter/cupertino.dart';

class Person {
  String birthday,
      biography,
      id,
      profileImg,
      placeOfBirth,
      imdbID,
      name,
      knownFor;
  Person(
      {@required this.id,
      this.name,
      this.imdbID,
      this.biography,
      this.birthday,
      this.profileImg,
      this.knownFor,
      this.placeOfBirth});
  @override
  String toString() {
    return 'person';
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/Models/Movie.dart';

class MovieContainer extends StatelessWidget {
  final Movie movie;
  const MovieContainer(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Image(
        image: NetworkImage(movie.posterurl),
        fit: BoxFit.contain,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/Presentdata.dart';

class MovieDetails extends StatefulWidget {
  final String id;
  MovieDetails(this.id);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();
    rebuild(widget.id);
  }

  Widget body = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: body,
    );
  }

  void rebuild(String id) {
    buildMovieContainer(id).then((moviecontainer) {
      setState(() {
        body = moviecontainer;
      });
    });
  }
}

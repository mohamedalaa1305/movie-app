import 'package:flutter/material.dart';
import 'package:movie_app/Models/TvShow.dart';
import 'package:movie_app/Templates/MovieContainer.dart';

class TvShowDetails extends StatefulWidget {
  final String id;
  TvShowDetails(this.id);

  @override
  _TvShowDetailsState createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  TvShow show;

  @override
  void initState() {
    super.initState();
    show = new TvShow(id: widget.id);
    rebuild();
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

  void rebuild() async {
    // await show.getDetails();
    // setState(() {
    //   body = MovieContainer(movie);
    // });
  }
}

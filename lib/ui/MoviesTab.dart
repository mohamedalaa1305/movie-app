import 'package:flutter/material.dart';
import 'package:movie_app/DataController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/Movie.dart';
import 'package:movie_app/Templates/HorizontalSection.dart';
import 'package:movie_app/Templates/SectionHeader.dart';
import 'package:provider/provider.dart';

class MoviesTab extends StatefulWidget {
  
  MoviesTab({
    Key key,
  }) : super(key: key);

  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  
  List<String> title = [
    'Trending',
    'Popular',
    'Now Playing',
    'Upcoming',
    'Top Rated'
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int idx) {
        return HorizontalSection(
          mediaType: 'movie',
          sectionTitle: title[idx],
          tabIndex: idx,
        );
      },
    );
  }
}

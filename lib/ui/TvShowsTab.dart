import 'package:flutter/material.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/Movie.dart';
import 'package:movie_app/Models/TvShow.dart';
import 'package:movie_app/Templates/HorizontalSection.dart';
import 'package:movie_app/Templates/SectionHeader.dart';
import 'package:provider/provider.dart';

import '../DataController.dart';

class TvShowsTab extends StatefulWidget {
  TvShowsTab({Key key}) : super(key: key);

  @override
  _TvShowsTabState createState() => _TvShowsTabState();
}

class _TvShowsTabState extends State<TvShowsTab> {
  List<Media> trending, popular, onTv, airingToday, topRated;

  List<String> title = [
    'Trending',
    'Popular',
    'On Tv',
    'Airing Today',
    'Top Rated'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dc = Provider.of<DataController>(context, listen: false);
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int idx) {
        return HorizontalSection(
          tabIndex: idx,
          mediaType: 'tv',
          sectionTitle: title[idx],
        );
      },
    );
  }
}

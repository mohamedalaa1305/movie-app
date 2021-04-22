import 'package:flutter/material.dart';
import 'package:movie_app/Templates/HorizontalSection.dart';

class MediaTab extends StatefulWidget {
  final String mediaType;
  MediaTab({Key key, @required this.mediaType}) : super(key: key);

  @override
  _MediaTabState createState() => _MediaTabState();
}

class _MediaTabState extends State<MediaTab> {
  List<String> title = [];
  @override
  void initState() {
    title = (widget.mediaType == 'movie')
        ? ['Trending', 'Popular', 'Now Playing', 'Upcoming', 'Top Rated']
        : ['Trending', 'Popular', 'On Tv', 'Airing Today', 'Top Rated'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int idx) {
        return HorizontalSection(
          mediaType: widget.mediaType,
          sectionTitle: title[idx],
          tabIndex: idx,
        );
      },
    );
  }
}

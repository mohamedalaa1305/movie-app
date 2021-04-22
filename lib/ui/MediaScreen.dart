import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Templates/MediaGrid.dart';
import 'package:flutter/services.dart';

class MediaScreen extends StatefulWidget {
  final String mediaType;
  final int tabIndex;
  MediaScreen({Key key, @required this.mediaType, this.tabIndex})
      : super(key: key);
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabs = (widget.mediaType == 'movie')
      ? [
          Tab(text: 'Trending'),
          Tab(text: 'Popular'),
          Tab(text: 'Now Playing'),
          Tab(text: 'Upcoming'),
          Tab(text: 'Top Rated'),
        ]
      : [
          Tab(text: 'Trending'),
          Tab(text: 'Popular'),
          Tab(text: 'On Tv'),
          Tab(text: 'Airing Today'),
          Tab(text: 'Top Rated'),
        ];
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(controllerListener);
    _controller.index = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kplatte1[1],
      appBar: AppBar(
        title: Text( (widget.mediaType == 'movie')? 'Movies' : 'Tv Shows'),
        backgroundColor: Kplatte1[1],
        brightness: Brightness.dark,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: true,
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: tabs,
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _controller,
          children: [
            MediaGrid(mediaType: widget.mediaType, tabIndex: 0),
            MediaGrid(mediaType: widget.mediaType, tabIndex: 1),
            MediaGrid(mediaType: widget.mediaType, tabIndex: 2),
            MediaGrid(mediaType: widget.mediaType, tabIndex: 3),
            MediaGrid(mediaType: widget.mediaType, tabIndex: 4),
          ],
        ),
      ),
    );
  }

  void controllerListener() {}
}

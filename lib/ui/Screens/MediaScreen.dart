import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            Tab(text: 'Netflix'),
            Tab(text: 'Top Rated'),
          ];
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(controllerListener);
    _controller.index = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: appTheme[background],
        body: SafeArea(
          child: DefaultTabController(
            length: 5,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    iconTheme: IconThemeData(color: appTheme[txt]),
                    backgroundColor: appTheme[background],
                    floating: true,
                    pinned: true,
                    snap: true,
                    title: Text(
                      (widget.mediaType == 'movie') ? 'Movies' : 'Tv Shows',
                      style: GoogleFonts.abel().copyWith(
                        color: appTheme[txt],
                      ),
                    ),
                    brightness: Brightness.dark,
                    foregroundColor: appTheme[txt],
                    automaticallyImplyLeading: true,
                    bottom: TabBar(
                      labelColor: appTheme[label],
                      unselectedLabelColor: appTheme[txt],
                      isScrollable: true,
                      controller: _controller,
                      tabs: tabs,
                      labelStyle: kTabTextStyle,
                    ),
                    actions: [],
                  ),
                ];
              },
              body: TabBarView(
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
          ),
        ),
      ),
    );
  }

  void controllerListener() {}
}

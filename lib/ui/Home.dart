import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Templates/MediaTab.dart';
import 'package:movie_app/ui/Menus/AppDrawer.dart';
import 'package:movie_app/ui/MoviesTab.dart';
import 'package:movie_app/ui/TvShowsTab.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Widget> tabs = [
    Tab(
      // text: 'MOVIES',
      icon: Icon(Icons.movie),
      iconMargin: EdgeInsets.all(2),
    ),
    Tab(
      iconMargin: EdgeInsets.all(2),
      // text: 'TV SHOWS',
      icon: Icon(Icons.live_tv),
    ),
  ];
  TextStyle txtstyle = GoogleFonts.abel(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    letterSpacing: 2,
  );
  TabController _controller;
  bool initialized = false;

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    _controller.addListener(controllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kplatte1[1],
      drawer: AppDrawer(),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  backgroundColor: Kplatte1[1],
                  bottom: TabBar(
                    controller: _controller,
                    labelStyle: txtstyle,
                    tabs: tabs,
                  ),
                  actions: [],
                  title: Text(
                    'Movie Box',
                    style: GoogleFonts.abel(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _controller,
              children: [
                MediaTab(mediaType: 'movie'),
                MediaTab(mediaType: 'tv'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void controllerListener() async {
    print("Inside Listener");
    if (_controller.index == 1 && !initialized) {
      initialized = true;
    }
  }
}

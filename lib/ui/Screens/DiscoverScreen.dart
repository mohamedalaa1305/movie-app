import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/DiscoverController.dart';
import 'package:movie_app/Controllers/SearchController.dart';
import 'package:movie_app/Controllers/ThemeController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Templates/NothingToShowContainer.dart';
import 'package:movie_app/Templates/SearchGrid.dart';
import 'package:movie_app/ui/Menus/AppDrawer.dart';
import 'package:movie_app/ui/Menus/MovieGenresMenu.dart';
import 'package:movie_app/ui/Menus/TvGenresMenu.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({Key key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  List<Widget> tabs = [
    Tab(
      icon: Icon(Icons.movie_rounded),
      iconMargin: EdgeInsets.all(2),
    ),
    Tab(
      iconMargin: EdgeInsets.all(2),
      icon: Icon(Icons.live_tv_rounded),
    ),
  ];

  TextStyle txtstyle = GoogleFonts.abel(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    letterSpacing: 2,
  );

  TabController _controller;

  bool initialized = false;
  int prev;
  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    _controller.addListener(controllerListener);
    super.initState();
  }

  bool visible = false;
  IconData icon = Icons.miscellaneous_services;
  @override
  Widget build(BuildContext context) {
    final tc = context.watch<ThemeController>();
    final dc = context.watch<DiscoverController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appTheme[button],
        child: Icon(
          icon,
          color: appTheme[txt],
        ),
        onPressed: () {
          setState(() {
            visible = !visible;
            icon = (icon == Icons.close_rounded)
                ? Icons.miscellaneous_services_rounded
                : Icons.close_rounded;
          });
        },
      ),
      drawer: AppDrawer(
        state: tc.state,
        idx: 2,
      ),
      backgroundColor: appTheme[background],
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  title: Text(
                    'Discover',
                    style: GoogleFonts.abel().copyWith(
                      color: appTheme[txt],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: appTheme[background],
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: TabBar(
                    labelColor: appTheme[button],
                    unselectedLabelColor: appTheme[txt],
                    controller: _controller,
                    labelStyle: txtstyle,
                    tabs: tabs,
                    indicatorColor: appTheme[button],
                  ),
                  iconTheme: IconThemeData(color: appTheme[txt]),
                  actionsIconTheme: IconThemeData(color: appTheme[txt]),
                  actions: [],
                  // title: Text('Action'),
                ),
              ];
            },
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      Selector<DiscoverController, List<Media>>(
                        selector: (_, data) => data.movies,
                        builder: (context, movies, child) {
                          // print("building movies");
                          if (movies == null ||
                              movies.isEmpty && !dc.moviesok) {
                            dc.getMovies('');
                            return loading;
                          }
                          if (movies.isEmpty && dc.moviesok)
                            return Center(child: NothingToShowContainer());
                          return SearchGrid(
                            media: dc.movies,
                            loadNext: dc.getMovies,
                          );
                        },
                      ),
                      Selector<DiscoverController, List<Media>>(
                        selector: (_, data) => data.shows,
                        builder: (context, shows, child) {
                          // print("building movies");
                          if (shows == null || shows.isEmpty && !dc.tvsok) {
                            dc.getShows('');
                            return loading;
                          }
                          if (shows.isEmpty && dc.tvsok)
                            return Center(child: NothingToShowContainer());
                          return SearchGrid(
                            media: dc.shows,
                            loadNext: dc.getShows,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // bottom: kFloatingActionButtonMargin,
                  bottom: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Visibility(
                    visible: visible,
                    child: (_controller.index == 0)
                        ? MovieGenresMenu()
                        : TvGenresMenu(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void controllerListener() {
    if (visible) {
      setState(() {
        visible = false;
        icon = Icons.miscellaneous_services_rounded;
      });
    }
    // final sc = context.read<SearchController>();
    // if (_controller.index == 0)
    //   sc.getMovies('');
    // else
    //   sc.getShows('');
  }

  void update(String qry) {
    // print("current query = " + qry);
    final sc = context.read<SearchController>();
    // sc.processQuery(qry, (_controller.index == 0) ? 'movie' : 'tv');
  }
}

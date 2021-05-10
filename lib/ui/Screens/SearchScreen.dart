import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/SearchController.dart';
import 'package:movie_app/Controllers/ThemeController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Templates/SearchGrid.dart';
import 'package:movie_app/ui/Menus/AppDrawer.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<Widget> tabs = [
    Tab(
      // text: 'MOVIES',
      icon: Icon(Icons.movie_rounded),
      iconMargin: EdgeInsets.all(2),
    ),
    Tab(
      iconMargin: EdgeInsets.all(2),
      // text: 'TV SHOWS',
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
    prev = _controller.index;
    final sc = context.read<SearchController>();
    sc.reset();
    sc.query = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sc = context.watch<SearchController>();
    final tc = context.read<ThemeController>();
    return Scaffold(
      drawer: AppDrawer(state: tc.state, idx: 1,),
      backgroundColor: appTheme[background],
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  backgroundColor: appTheme[background],
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: TabBar(
                    labelColor: appTheme[label],
                    unselectedLabelColor: appTheme[txt],
                    controller: _controller,
                    labelStyle: txtstyle,
                    tabs: tabs,
                    indicatorColor: appTheme[label],
                  ),
                  iconTheme: IconThemeData(color: appTheme[txt]),
                  actions: [],
                  title: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      hintStyle: GoogleFonts.abel().copyWith(
                        color: appTheme[subText],
                        fontSize: 16,
                      ),
                      hoverColor: appTheme[txt],
                      fillColor: appTheme[txt],
                      hintText: 'Enter a search term',
                    ),
                    cursorColor: appTheme[txt],
                    style: GoogleFonts.abel().copyWith(
                      color: appTheme[txt],
                      fontSize: 16,
                    ),
                    onChanged: (qry) => update(qry),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _controller,
              children: [
                Selector<SearchController, List<Media>>(
                  selector: (_, data) => data.movies,
                  builder: (context, movies, child) {
                    // print("building movies");
                    if (movies == null || movies.isEmpty)
                      return Center(
                        child: Text(
                          'No Results Found',
                          style: GoogleFonts.abel().copyWith(
                            color: appTheme[subText],
                            fontSize: 24,
                          ),
                        ),
                      );
                    return SearchGrid(
                      media: sc.movies,
                      loadNext: sc.getMovies,
                    );
                  },
                ),
                Selector<SearchController, List<Media>>(
                  selector: (_, data) => data.shows,
                  builder: (context, shows, child) {
                    // print("Building shows");
                    if (shows == null || shows.isEmpty)
                      return Center(
                        child: Text(
                          'No Results Found',
                          style: GoogleFonts.abel().copyWith(
                            color: appTheme[subText],
                            fontSize: 24,
                          ),
                        ),
                      );
                    return SearchGrid(
                      media: shows,
                      loadNext: sc.getShows,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void controllerListener() {
    final sc = context.read<SearchController>();
    // print("index = " + _controller.index.toString());
    if (_controller.index == 0)
      sc.getMovies('');
    else
      sc.getShows('');
  }

  void update(String qry) {
    // print("current query = " + qry);
    final sc = context.read<SearchController>();
    sc.processQuery(qry, (_controller.index == 0) ? 'movie' : 'tv');
  }
}

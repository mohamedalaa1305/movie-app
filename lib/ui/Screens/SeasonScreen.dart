import 'package:flutter/material.dart';
import 'package:movie_app/Controllers/SeasonController.dart';
import 'package:movie_app/Models/TvShow.dart';
import 'package:movie_app/Templates/CustomFlexibleSpaceBar.dart';
import 'package:movie_app/Templates/EpisodeCard.dart';
import 'package:movie_app/Templates/InfoRow.dart';
import 'package:movie_app/Templates/OverviewContainer.dart';
import 'package:movie_app/Templates/SectionHead.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Helper.dart';
import 'HomeScreen.dart';

class SeasonScreen extends StatelessWidget {
  final String number, id;
  final TvShow show;
  const SeasonScreen({
    Key key,
    this.number,
    this.id,
    this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeasonController(),
      child: Scaffold(
        backgroundColor: appTheme[background],
        body: SafeArea(
          child: Consumer<SeasonController>(
            builder: (_, data, __) {
              if (data.season == null || data.season.id != id) {
                data.downloadSeason(show.id, number, show.title);
                return loading;
              }
              return buildBody(data, context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(SeasonController data, BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: false,
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: appTheme[background],
            floating: false,
            primary: true,
            pinned: true,
            snap: false,
            actionsIconTheme: IconThemeData(color: appTheme[txt]),
            iconTheme: IconThemeData(color: appTheme[txt]),
            actions: [
              IconButton(
                onPressed: () => navigatePushOnly(context, Home()),
                icon: Icon(Icons.home),
              ),
            ],
            brightness: Brightness.dark,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) => CustomFlexibleSpaceBar(
                parentcontext: context,
                constraints: constraints,
                title: show.title + ' - ' + data.season.name,
                backdropUrl: show?.backdropurl ?? 'null',
                posterUrl: data.season?.posterurl ?? 'null',
                rating: show?.voteavg ?? 'null',
                voteCount: show?.votecount ?? 'null',
                trailerUrl: data.season.trailer?.key ?? 'null',
                info2: InfoRow(
                  icon: Icons.list_rounded,
                  iconsize: 12,
                  info: splitByDots(show?.genres) ?? '',
                  mxlines: 2,
                ),
                info3: InfoRow(
                  info: (data.season.airdate.length > 3)
                      ? data.season.airdate.substring(0, 4)
                      : 'unknown',
                  icon: Icons.calendar_today_rounded,
                  iconsize: 12,
                  mxlines: 1,
                ),
              ),
            ),
          ),
        ];
      },
      body: ListView(
        children: [
          OverviewContainer(overview: data.season.overview),
          SectionHead(
            title: 'Episodes',
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: List.generate(
                  data.season.episodes.length,
                  (index) => EpisodeCard(episode: data.season.episodes[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

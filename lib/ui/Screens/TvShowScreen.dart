import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Controllers/TvShowController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/Templates/CustomFlexibleSpaceBar.dart';
import 'package:movie_app/Templates/Images.dart';
import 'package:movie_app/Templates/InfoRow.dart';
import 'package:movie_app/Templates/Loading.dart';
import 'package:movie_app/Templates/MediaSection.dart';
import 'package:movie_app/Templates/NothingToShowContainer.dart';
import 'package:movie_app/Templates/OverviewContainer.dart';
import 'package:movie_app/Templates/PersonSection.dart';
import 'package:movie_app/Templates/SeasonsSection.dart';
import 'package:movie_app/Templates/SectionHead.dart';
import 'package:movie_app/Templates/Videos.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../Helper.dart';
import 'HomeScreen.dart';

class TvShowScreen extends StatelessWidget {
  final String id, title;
  TvShowScreen({
    @required this.id,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TvShowController(),
      child: Scaffold(
        backgroundColor: appTheme[background],
        body: SafeArea(
          child: Consumer<TvShowController>(
            builder: (_, data, __) {
              if (data.show == null || data.show.id != id) {
                data.downloadShow(id);
                return loading;
              }
              return buildBody(data, context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(TvShowController data, BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: appTheme[background],
            pinned: true,
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
                title: data.show.title,
                backdropUrl: data.show?.backdropurl ?? 'null',
                posterUrl: data.show?.posterurl ?? 'null',
                rating: data.show?.voteavg ?? 'null',
                voteCount: data.show?.votecount ?? 'null',
                trailerUrl: data.show.trailer?.key ?? 'null',
                mediaType: 'tv',
                info1: InfoRow(
                  icon: Icons.list_rounded,
                  iconsize: 12,
                  info: splitByDots(data.show?.genres) ?? '',
                  mxlines: 2,
                ),
                info2: InfoRow(
                  icon: Icons.calendar_today_rounded,
                  iconsize: 12,
                  info: data.show?.releasedate ?? 'unknown',
                  mxlines: 1,
                ),
                info3: InfoRow(
                  info: data.show?.status ?? 'null',
                  icon: Icons.live_tv_rounded,
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
          OverviewContainer(overview: data.show.overview),
          SectionHead(
            title: 'Seasons',
            child: SeasonsSection(seasons: data.show.seasons, show: data.show),
          ),
          SectionHead(
            title: 'Cast',
            child: Selector<TvShowController, List<Person>>(
              selector: (_, data) => data.show.cast,
              builder: (context, cast, child) {
                if (cast == null) {
                  data.downloadCredits();
                  return Loading(
                      height: MediaQuery.of(context).size.width * 0.38);
                } else if (cast.isEmpty) return NothingToShowContainer();
                return PersonSection(media: cast);
              },
            ),
          ),
          SectionHead(
            title: 'Crew',
            child: Selector<TvShowController, List<Person>>(
              selector: (_, data) => data.show.crew,
              builder: (context, crew, child) {
                if (crew == null) {
                  data.downloadCredits();
                  return Loading(
                    height: MediaQuery.of(context).size.width * 0.38,
                  );
                } else if (crew.isEmpty) return NothingToShowContainer();
                return PersonSection(media: crew);
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: SectionHead(
              title: 'Images',
              child: Selector<TvShowController, List<MediaImage>>(
                selector: (_, data) => data.show.posters,
                builder: (context, posters, child) {
                  if (posters == null) {
                    data.downloadImages();
                    return loading;
                  }
                  if (posters.isEmpty) return NothingToShowContainer();
                  return Images(
                    backdropUrl: data.show.backdropurl,
                    backdrops: data.show.backdrops,
                    posterUrl: data.show.posterurl,
                    posters: data.show.posters,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.55,
            child: SectionHead(
              title: 'Videos',
              child: Selector<TvShowController, List<MediaVideo>>(
                selector: (_, data) => data.show.videos,
                builder: (_, videos, __) {
                  if (videos == null) {
                    data.downloadVideos();
                    return loading;
                  }
                  if (videos.isEmpty) return NothingToShowContainer();
                  return Videos(videos: videos);
                },
              ),
            ),
          ),
          SectionHead(
            title: 'Similar',
            child: Selector<TvShowController, List<Media>>(
              selector: (_, data) => data.show.similar,
              builder: (_, similar, __) {
                if (similar == null) {
                  data.downloadSimilar();
                  return Loading(
                    height: MediaQuery.of(context).size.height * 0.235,
                  );
                }
                if (similar.isEmpty) return NothingToShowContainer();
                return MediaSection(
                  media: similar,
                  loadNext: data.downloadSimilar,
                );
              },
            ),
          ),
          SectionHead(
            title: 'Recommendations',
            child: Selector<TvShowController, List<Media>>(
              selector: (_, data) => data.show.recommendations,
              builder: (_, recommendations, __) {
                if (recommendations == null) {
                  data.downloadRecommendations();
                  return Loading(
                    height: MediaQuery.of(context).size.height * 0.235,
                  );
                }
                if (recommendations.isEmpty) return NothingToShowContainer();
                return MediaSection(
                  media: recommendations,
                  loadNext: data.downloadRecommendations,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//? details
//? credits
//? images
//? videos
//? similar
//? recommendations

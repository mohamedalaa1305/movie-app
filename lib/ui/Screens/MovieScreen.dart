import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/MovieController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/Templates/Images.dart';
import 'package:movie_app/Templates/CustomFlexibleSpaceBar.dart';
import 'package:movie_app/Templates/Loading.dart';
import 'package:movie_app/Templates/MediaSection.dart';
import 'package:movie_app/Templates/SectionHead.dart';
import 'package:movie_app/Templates/NothingToShowContainer.dart';
import 'package:movie_app/Templates/OverviewContainer.dart';
import 'package:movie_app/Templates/PersonSection.dart';
import 'package:movie_app/ui/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import '../../Helper.dart';
import 'package:movie_app/Templates/Videos.dart';

class MovieScreen extends StatelessWidget {
  final String id, title;
  MovieScreen({
    @required this.id,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieController(),
      child: Scaffold(
        backgroundColor: Kplatte1[1],
        body: SafeArea(
          child: Consumer<MovieController>(
            builder: (_, data, __) {
              if (data.movie == null || data.movie.id != id) {
                data.downloadMovie(id);
                return loading;
              }
              return buildBody(data, context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(MovieController data, BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: Kplatte1[1],
            pinned: true,
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
                title: data.movie.title,
                backdropUrl: data.movie?.backdropurl ?? 'null',
                posterUrl: data.movie?.posterurl ?? 'null',
                rating: data.movie?.voteavg ?? 'null',
                voteCount: data.movie?.votecount ?? 'null',
                line1: splitByDots(data.movie?.genres) ?? '',
                line2: data.movie?.releasedate ?? 'unknown',
                line3: toHoursandMinutes(data.movie?.runtime) ?? 'null',
                trailerUrl: data.movie.trailer?.key ?? 'null',
                mediaType: 'movie',
              ),
            ),
          ),
        ];
      },
      body: ListView(
        children: [
          OverviewContainer(overview: data.movie.overview),
          SectionHead(
            title: 'Cast',
            child: Selector<MovieController, List<Person>>(
              selector: (_, data) => data.movie.cast,
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
            child: Selector<MovieController, List<Person>>(
              selector: (_, data) => data.movie.crew,
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
              child: Selector<MovieController, List<MediaImage>>(
                selector: (_, data) => data.movie.posters,
                builder: (context, posters, child) {
                  if (posters == null) {
                    data.downloadImages();
                    return loading;
                  }
                  if (posters.isEmpty) return NothingToShowContainer();
                  return Images(
                    backdropUrl: data.movie.backdropurl,
                    backdrops: data.movie.backdrops,
                    posterUrl: data.movie.posterurl,
                    posters: data.movie.posters,
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
              child: Selector<MovieController, List<MediaVideo>>(
                selector: (_, data) => data.movie.videos,
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
            child: Selector<MovieController, List<Media>>(
              selector: (_, data) => data.movie.similar,
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
            child: Selector<MovieController, List<Media>>(
              selector: (_, data) => data.movie.recommendations,
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

import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Models/Movie.dart';
import 'package:movie_app/Templates/MovieContainer.dart';
import 'package:movie_app/ui/Home.dart';
import 'Constants.dart';
import 'Models/Media.dart';
import 'Models/TvShow.dart';
import 'Network.dart';
import 'Templates/PosterContainer.dart';

final Network api = new Network();

Future buildMovieContainer(String iD) async {
  Movie movie = await getMovie(iD);
  return MovieContainer(movie);
}

// Future getTrending(
//     BuildContext context, String mediaType, String trendingTime) async {
//   var trending = [];
//   for (int i = 1; i <= 2; i++) {
//     var response = await api.getTrending(mediaType, trendingTime, i);
//     trending.addAll(toMediaList(response, mediaType));
//   }
//   Widget grid = GridView.count(
//     crossAxisCount: 3,
//     childAspectRatio:
//         (MediaQuery.of(context).size.width * (1 - 0.001 * 4) / 3.0) / 180,
//     children: List.generate(trending.length, (index) {
//       return PosterConatainer(
//         id: trending[index].id,
//         mediaType: mediaType,
//         posterUrl: trending[index].posterurl,
//       );
//     }),
//   );
//   return grid;
// }

// Future getTrending0(String mediaType, String trendingTime, int page) async {
//   List<Media> trending = [];
//   Network apii = new Network();
//   var response = await apii.getTrending(mediaType, trendingTime, page);
//   trending.addAll(toMediaList(response, mediaType));
//   print("trending size = ");
//   print(trending.length);
//   return trending;
// }

// Future getPopular(String mediaType, int page) async {
//   List<Media> popular = [];
//   Network apii = new Network();
//   var response = await apii.getPopular(mediaType, page);
//   popular.addAll(toMediaList(response, mediaType));
//   return popular;
// }

// Future getTopRated(String mediaType, int page) async {
//   List<Media> topRated = [];
//   var response = await api.getTopRated(mediaType, page);
//   topRated.addAll(toMediaList(response, mediaType));
//   return topRated;
// }

// Future getUpcoming(int page) async {
//   List<Media> upcoming = [];
//   var response = await api.getUpcoming(page);
//   upcoming.addAll(toMediaList(response, 'movie'));
//   return upcoming;
// }

// Future getNowPlaying(int page) async {
//   List<Media> nowPlaying = [];
//   var response = await api.getNowPlaying(page);
//   nowPlaying.addAll(toMediaList(response, 'movie'));
//   return nowPlaying;
// }

// Future getOnTv(int page) async {
//   List<Media> onTv = [];
//   var response = await api.getOnTv(page);
//   onTv.addAll(toMediaList(response, 'tv'));
//   return onTv;
// }

// Future getAiringToday(int page) async {
//   List<Media> airingToday = [];
//   var response = await api.getAiringToday(page);
//   airingToday.addAll(toMediaList(response, 'tv'));
//   return airingToday;
// }

Future<Movie> getMovie(String iD) async {
  var response = await api.getMovie(iD);
  return toMedia(response);
}

Media toMedia(var response) {
  List<dynamic> genresmap = response['genres'];
  List<String> genres = [];
  for (int i = 0; i < genresmap.length; i++) genres.add(genresmap[i]['name']);

  Media media = new Movie(
    id: (response['id']).toString(),
    posterurl: Network.imgbaseurlw780 + (response['poster_path']).toString(),
    title: (response['title']).toString(),
    genres: genres,
    overview: (response['overview']).toString(),
    releasedate: (response['release_date']).toString(),
    runtime: (response['runtime']).toString(),
    voteavg: (response['vote_average']).toString(),
    votecount: (response['vote_count']).toString(),
  );
  return media;
}

// List<Media> toMediaList(var response, String mediaType) {
//   List<Media> list = [];
//   for (int j = 0; j < 20; j++) {
//     String id = (response['results'][j]['id']).toString();
//     String posterPath = (response['results'][j]['poster_path']).toString();
//     String title = (response['results'][j]['title']).toString();
//     String posterurl = Network.imgbaseurlw185 + posterPath;
//     (mediaType == 'tv')
//         ? list.add(new TvShow(id: id, posterurl: posterurl, title: title))
//         : list.add(new Movie(id: id, posterurl: posterurl, title: title));
//   }
//   return list;
// }

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:movie_app/Models/Media.dart';

import 'Models/Movie.dart';
import 'Models/TvShow.dart';
import 'Network.dart';

final Network api = new Network();

class DataController with ChangeNotifier {
  List<Media> trendingMovies = [],
      popularMovies = [],
      upcoming = [],
      nowPlaying = [],
      topRatedMovies = [],
      trendingTvShows = [],
      popularTvShows = [],
      airingToday = [],
      onTv = [],
      topRatedTvShows = [];

  int trendingMoviesNextPage = 1,
      popularMoviesNextPage = 1,
      upcomingNextPage = 1,
      nowPlayingNextPage = 1,
      topRatedMoviesNextPage = 1,
      trendingTvShowsNextPage = 1,
      popularTvShowsNextPage = 1,
      airingTodayNextPage = 1,
      onTvNextPage = 1,
      topRatedTvShowsNextPage = 1;

  List<Media> getList(String mediaType, int idx) {
    switch (idx) {
      case 0:
        return (mediaType == 'movie') ? trendingMovies : trendingTvShows;
      case 1:
        return (mediaType == 'movie') ? popularMovies : popularTvShows;
      case 2:
        return (mediaType == 'movie') ? nowPlaying : onTv;
      case 3:
        return (mediaType == 'movie') ? upcoming : airingToday;
      case 4:
        return (mediaType == 'movie') ? topRatedMovies : topRatedTvShows;
      default:
        return null;
    }
  }

  Future<void> getTrending(String mediaType, String trendingTime) async {
    print('data controller is getting trending');
    var response = (mediaType == 'movie')
        ? await api.getTrending(
            mediaType, trendingTime, trendingMoviesNextPage++)
        : await api.getTrending(
            mediaType, trendingTime, trendingTvShowsNextPage++);
    print('get trending done');
    (mediaType == 'movie')
        ? trendingMovies.addAll(toMediaList(response, mediaType))
        : trendingTvShows.addAll(toMediaList(response, mediaType));
    print('added trending to the list');
    stdout.write('length = ' + trendingMovies.length.toString() + '\n');
    notifyListeners();
  }

  Future<void> getPopular(String mediaType) async {
    var response = (mediaType == 'movie')
        ? await api.getPopular(mediaType, popularMoviesNextPage++)
        : await api.getPopular(mediaType, popularTvShowsNextPage++);

    (mediaType == 'movie')
        ? popularMovies.addAll(toMediaList(response, mediaType))
        : popularTvShows.addAll(toMediaList(response, mediaType));
    notifyListeners();
  }

  Future<void> getTopRated(String mediaType) async {
    var response = (mediaType == 'movie')
        ? await api.getTopRated(mediaType, topRatedMoviesNextPage++)
        : await api.getTopRated(mediaType, topRatedTvShowsNextPage++);

    (mediaType == 'movie')
        ? topRatedMovies.addAll(toMediaList(response, mediaType))
        : topRatedTvShows.addAll(toMediaList(response, mediaType));
    notifyListeners();
  }

  Future<void> getUpcoming() async {
    var response = await api.getUpcoming(upcomingNextPage++);
    upcoming.addAll(toMediaList(response, 'movie'));
    notifyListeners();
  }

  Future<void> getNowPlaying() async {
    var response = await api.getNowPlaying(nowPlayingNextPage++);
    nowPlaying.addAll(toMediaList(response, 'movie'));
    notifyListeners();
  }

  Future<void> getOnTv() async {
    var response = await api.getOnTv(onTvNextPage++);
    onTv.addAll(toMediaList(response, 'tv'));
    notifyListeners();
  }

  Future<void> getAiringToday() async {
    var response = await api.getAiringToday(airingTodayNextPage++);
    airingToday.addAll(toMediaList(response, 'tv'));
    notifyListeners();
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

  List<Media> toMediaList(var response, String mediaType) {
    List<Media> list = [];
    for (int j = 0; j < 20; j++) {
      String id = (response['results'][j]['id']).toString();
      String posterPath = (response['results'][j]['poster_path']).toString();
      String title = (response['results'][j]['title']).toString();
      String posterurl = Network.imgbaseurlw185 + posterPath;
      (mediaType == 'tv')
          ? list.add(new TvShow(id: id, posterurl: posterurl, title: title))
          : list.add(new Movie(id: id, posterurl: posterurl, title: title));
    }
    return list;
  }

  Future<void> loadNext(String mediaType, int tabIndex) async {
    stdout.write('getting next page of ' +
        mediaType +
        ' tab number ' +
        tabIndex.toString() +
        '\n');
    switch (tabIndex) {
      case 0:
        await getTrending(mediaType, 'day');
        break;
      case 1:
        await getPopular(mediaType);
        break;
      case 2:
        await ((mediaType == 'movie') ? getNowPlaying() : getOnTv());
        break;
      case 3:
        await ((mediaType == 'movie') ? getUpcoming() : getAiringToday());
        break;
      case 4:
        await getTopRated(mediaType);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Media.dart';

class DiscoverController with ChangeNotifier {
  List<bool> moviecbx = new List.generate(movieGenres.length, (index) => false);
  List<bool> tvcbx = new List.generate(tvGenres.length, (index) => false);
  List<Media> movies = [], shows = [];
  Set<String> moviegenreids = {};
  Set<String> tvgenreids = {};
  int moviePage = 1, tvPage = 1;
  String moviequery = '';
  String tvquery = '';
  bool moviesok = false;
  bool tvsok = false;
  void buildQuery(String mediaType) {
    Set<String> ids = (mediaType == 'movie') ? moviegenreids : tvgenreids;
    String ans = "";
    for (var id in ids) (ans.isEmpty) ? ans += id : ans += ',' + id;
    (mediaType == 'movie') ? moviequery = ans : tvquery = ans;
    print("query done = " + ans);
    processQuery(mediaType);
  }

  void addGenre(int idx, String mediaType) {
    print("building query");
    if (mediaType == 'movie') {
      moviecbx[idx] = true;
      moviegenreids.add(movieGenres.values.toList()[idx]);
    } else {
      tvcbx[idx] = true;
      tvgenreids.add(tvGenres.values.toList()[idx]);
    }
    notifyListeners();
    reset(mediaType);
    buildQuery(mediaType);
  }

  void removeGenre(int idx, String mediaType) {
    if (mediaType == 'movie') {
      moviecbx[idx] = false;
      moviegenreids.remove(movieGenres.values.toList()[idx]);
    } else {
      tvcbx[idx] = false;
      tvgenreids.remove(tvGenres.values.toList()[idx]);
    }
    notifyListeners();
    reset(mediaType);
    buildQuery(mediaType);
  }

  Future<void> processQuery(String mediaType) async {
    if (mediaType == 'movie') await getMovies(moviequery);
    if (mediaType == 'tv') await getShows(tvquery);
  }

  Future<void> getMovies(String qry) async {
    if (qry == '') qry = moviequery;
    print("getting movies");
    print("page = " + moviePage.toString());
    var response = await api.discover('movie', qry, moviePage++);
    movies.addAll(toMediaList(response, 'movie'));
    moviesok = true;
    print("movies len = " + movies.length.toString());
    notifyListeners();
  }

  Future<void> getShows(String qry) async {
    if (qry == '') qry = tvquery;
    print("getting shows");
    var response = await api.discover('tv', qry, tvPage++);
    shows.addAll(toMediaList(response, 'tv'));
    tvsok = true;
    print("shows len = " + shows.length.toString());
    notifyListeners();
  }

  void reset(String mediaType) {
    print("resetting");
    if (mediaType == 'movie') {
      moviePage = 1;
      movies = [];
      moviesok = false;
    } else {
      tvPage = 1;
      shows = [];
      tvsok = false;
    }
  }
}

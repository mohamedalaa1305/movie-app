import 'package:flutter/material.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Media.dart';

import '../Constants.dart';

class SearchController with ChangeNotifier {
  List<Media> movies = [], shows = [];
  String query = '';
  int moviePage = 1, tvPage = 1;
  Future<void> processQuery(String qry, String mediaType) async {
    if (qry == '') {
      reset();
      notifyListeners();
      return;
    }
    // print("processing qry " + qry + "  mediatype = " + mediaType);
    // print("last qry was " + query);
    if (qry != query) {
      reset();
      query = qry;
    }
    if (mediaType == 'movie') await getMovies(qry);
    if (mediaType == 'tv') await getShows(qry);
  }

  Future<void> getMovies(String qry) async {
    if (qry == '') qry = query;
    // print("getting movies qry = " + qry);
    var response = await api.search('movie', qry, moviePage++);
    movies.addAll(toMediaList(response, 'movie'));
    notifyListeners();
    // print("movies len = " + movies.length.toString());
    // print("listners notified");
  }

  Future<void> getShows(String qry) async {
    if (qry == '') qry = query;
    // print("getting shows qry = " + qry);
    var response = await api.search('tv', qry, tvPage++);
    shows.addAll(toMediaList(response, 'tv'));
    // print("shows len = " + shows.length.toString());
    notifyListeners();
    // print("listners notified");
  }

  void reset() {
    moviePage = 1;
    tvPage = 1;
    movies = [];
    shows = [];
  }
}

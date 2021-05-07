import 'package:flutter/cupertino.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Movie.dart';

class MovieController with ChangeNotifier {
  Movie movie;

  void downloadMovie(String id) async {
    movie = new Movie(id: id);
    var response = await api.getDetails(movie.id, 'movie');
    movie = toMedia(response, 'movie');
    await downloadVideos();
    notifyListeners();
  }

  void downloadSimilar() async {
    await movie.getSimilar();
    notifyListeners();
  }

  void downloadRecommendations() async {
    await movie.getRecommendations();
    notifyListeners();
  }

  void downloadCredits() async {
    await movie.getCredits();
    notifyListeners();
  }

  void downloadImages() async {
    await movie.getImages();
    notifyListeners();
  }

  Future<void> downloadVideos() async {
    await movie.getVideos();
    notifyListeners();
  }
}

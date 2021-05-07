import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/TvShow.dart';

import '../Helper.dart';

class TvShowController with ChangeNotifier {

  TvShow show;

  void downloadShow(String id) async {
    show = new TvShow(id: id);
    var response = await api.getDetails(show.id, 'tv');
    show = toMedia(response, 'tv');
    notifyListeners();
  }

  void downloadSimilar() async {
    await show.getSimilar();
    notifyListeners();
  }

  void downloadRecommendations() async {
    await show.getRecommendations();
    notifyListeners();
  }

  void downloadCredits() async {
    await show.getCredits();
    notifyListeners();
  }

  void downloadImages() async {
    await show.getImages();
    notifyListeners();
  }

  void downloadVideos() async {
    await show.getVideos();
    notifyListeners();
  }
  
}

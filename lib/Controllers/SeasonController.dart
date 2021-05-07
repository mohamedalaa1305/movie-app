import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/Season.dart';
import '../Constants.dart';
import '../Helper.dart';

class SeasonController with ChangeNotifier {
  Season season;
  void downloadSeason(String tvid, String number) async {
    season = new Season(tvid: tvid, number: number);
    var response = await api.getSeason(tvid, number);
    season = toSeason(response, tvid);
    await downloadVideos();
    notifyListeners();
  }

  Future<void> downloadVideos() async {
    await season.getVideos();
    notifyListeners();
  }

  Future<void> downloadImages() async {
    await season.getImages();
    notifyListeners();
  }
}

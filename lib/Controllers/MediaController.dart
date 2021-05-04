import 'package:flutter/foundation.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'package:movie_app/Models/Movie.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/Models/TvShow.dart';
import 'package:movie_app/Network.dart';

import '../Helper.dart';

Network api = new Network();

class MediaController with ChangeNotifier {
  Movie movie = new Movie(id: '-1');
  TvShow show = new TvShow(id: '-1');
  Person person = new Person(id: '-1');

  void downloadMovie(String id) async {
    await getDetails(id, 'movie');
    notifyListeners();
  }

  void downloadShow(String id) async {
    await getDetails(id, 'tv');
    await show.getCredits();
    notifyListeners();
  }

  void downloadSimilar(String mediaType) async {
    (mediaType == 'movie') ? await movie.getSimilar() : await show.getSimilar();
    notifyListeners();
  }

  void downloadRecommendations(String mediaType) async {
    (mediaType == 'movie')
        ? await movie.getRecommendations()
        : await show.getRecommendations();
    notifyListeners();
  }

  void downloadCredits(String mediaType) async {
    (mediaType == 'movie') ? await movie.getCredits() : await show.getCredits();
    notifyListeners();
  }

  void downloadImages(String mediaType) async {
    (mediaType == 'movie') ? await movie.getImages() : await show.getImages();
    notifyListeners();
  }

  void downloadVideos(String mediaType) async {
    (mediaType == 'movie') ? await movie.getVideos() : await show.getVideos();
    notifyListeners();
  }

  void downloadInfo(String mediaType, String id) {
    (mediaType == 'movie') ? downloadMovie(id) : downloadShow(id);
  }

  Future<void> getDetails(String id, String mediaType) async {
    var response = await api.getDetails(id, mediaType);
    (mediaType == 'tv')
        ? show = toMedia(response, mediaType)
        : movie = toMedia(response, mediaType);
  }

  String getTitle(String mediaType) {
    return (mediaType == 'movie') ? movie.title : show.title;
  }

  String getBackdropUrl(String mediaType) {
    return (mediaType == 'movie') ? movie.backdropurl : show.backdropurl;
  }

  String getPosterUrl(String mediaType) {
    return (mediaType == 'movie') ? movie.posterurl : show.posterurl;
  }

  bool newId(String mediaType, String id) {
    return (mediaType == 'movie') ? id != movie.id : id != show.id;
  }

  String getVoteCount(String mediaType) {
    return (mediaType == 'movie') ? movie.votecount : show.votecount;
  }

  String getVoteAvg(String mediaType) {
    return (mediaType == 'movie') ? movie.voteavg : show.voteavg;
  }

  String getGenres(String mediaType) {
    return splitByDots((mediaType == 'movie') ? movie.genres : show.genres);
  }

  String getReleaseDate(String mediaType) {
    return (mediaType == 'movie') ? movie.releasedate : show.releasedate;
  }

  String getRuntime() {
    return toHoursandMinutes(movie.runtime);
  }

  List<Media> getCast(String mediaType) {
    return (mediaType == 'movie') ? movie.cast : show.cast;
  }

  List<Media> getCrew(String mediaType) {
    return (mediaType == 'movie') ? movie.crew : show.crew;
  }

  List<Media> getSimilar(String mediaType) {
    return (mediaType == 'movie') ? movie.similar : show.similar;
  }

  List<Media> getRecommendatoins(String mediaType) {
    return (mediaType == 'movie')
        ? movie.recommendations
        : show.recommendations;
  }

  List<MediaImage> getBackdrops(String mediaType) {
    return (mediaType == 'movie') ? movie.backdrops : show.backdrops;
  }

  List<MediaImage> getPosters(String mediaType) {
    return (mediaType == 'movie') ? movie.posters : show.posters;
  }

  List<MediaVideo> getVideos(String mediaType) {
    return (mediaType == 'movie') ? movie.videos : show.videos;
  }

  String getOverview(String mediaType) {
    return (mediaType == 'movie') ? movie.overview : show.overview;
  }

  int getTotalSimilar(String mediaType) {
    return (mediaType == 'movie') ? movie.totalsimilar : show.totalsimilar;
  }

  int getTotalRecommendations(String mediaType) {
    return (mediaType == 'movie')
        ? movie.totalrecommendations
        : show.totalrecommendations;
  }

  bool getDownloadedCredits(String mediaType) {
    return (mediaType == 'movie')
        ? movie.downloadedCredits
        : show.downloadedCredits;
  }

  bool getDownloadedVideos(String mediaType) {
    return (mediaType == 'movie')
        ? movie.downloadedVideos
        : show.downloadedVideos;
  }

  bool hasTrailer(String mediatype) {
    return (mediatype == 'movie')
        ? movie.trailer.key != '-1'
        : show.trailer.key != '-1';
  }

  String getTrailerUrl(String mediaType) {
    return (mediaType == 'movie') ? movie.trailer.key : show.trailer.key;
  }

  String getId(String mediaType) {
    return (mediaType == 'movie') ? movie.id : show.id;
  }
}

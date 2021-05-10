import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'package:movie_app/Network.dart';
import '../Helper.dart';
import 'Person..dart';

Network api = new Network();

class Media {
  int recommendationspageidx,
      similarpageidx,
      similarpages,
      recommendationspages,
      totalsimilar,
      totalrecommendations;
  bool downloadedCredits, downloadedVideos;
  MediaVideo trailer;
  String id,
      title,
      posterurl,
      backdropurl,
      overview,
      releasedate,
      runtime,
      votecount,
      voteavg,
      status,
      mediaType,
      imdbID;
  List<String> genres;
  List<Person> cast;
  List<Person> crew;
  List<MediaImage> posters, backdrops;
  List<MediaVideo> videos;
  List<Media> recommendations, similar;
  Media({
    this.id,
    this.posterurl,
    this.status,
    this.title,
    this.genres,
    this.overview,
    this.releasedate,
    this.runtime,
    this.voteavg,
    this.votecount,
    this.imdbID,
    this.cast,
    this.crew,
    this.backdrops,
    this.posters,
    this.videos,
    this.backdropurl,
    this.recommendations,
    this.similar,
    this.mediaType,
  }) {
    recommendationspageidx = 1;
    similarpageidx = 1;
    similarpages = -1;
    recommendationspages = -1;
    totalsimilar = -1;
    totalrecommendations = -1;
    downloadedCredits = false;
  }
  Media.clone(Media media) {
    this.id = media.id;
    this.recommendationspageidx = media.recommendationspageidx;
    this.similarpageidx = media.similarpageidx;
    this.similarpages = media.similarpages;
    this.recommendationspages = media.recommendationspages;
    this.totalsimilar = media.totalsimilar;
    this.totalrecommendations = media.totalrecommendations;
    this.downloadedCredits = media.downloadedCredits;
//?    this.trailer = new MediaVideo.clone(media.trailer);
    this.id = media.id;
    this.title = media.title;
    this.posterurl = media.posterurl;
    this.backdropurl = media.backdropurl;
    this.overview = media.overview;
    this.releasedate = media.releasedate;
    this.runtime = media.runtime;
    this.votecount = media.votecount;
    this.voteavg = media.voteavg;
    this.status = media.status;
    this.mediaType = media.mediaType;
    this.imdbID = media.imdbID;
    this.genres = new List<String>.from(media.genres);
    this.cast = new List<Person>.from(media.cast);
    this.crew = new List<Person>.from(media.crew);
    this.mediaType = media.mediaType;
    this.posters = new List<MediaImage>.from(media.posters);
    this.backdrops = new List<MediaImage>.from(media.backdrops);
    this.recommendations= new List<Media>.from(media.recommendations);
    this.similar = new List<Media>.from(media.similar);
    this.videos = new List<MediaVideo>.from(media.videos);
  }

  Future<void> getCredits() async {
    var response = await api.getCredits(id, mediaType);
    this.cast = removeDuplicates(fetchCredits(response, 'cast'), 'cast');
    this.crew = removeDuplicates(fetchCredits(response, 'crew'), 'crew');

    downloadedCredits = true;
  }

  Future<void> getRecommendations() async {
    if (recommendationspageidx >= recommendationspages &&
        recommendationspages != -1) return;

    var response =
        await api.getRecommendations(id, mediaType, recommendationspageidx++);
    this.recommendationspages = response['total_pages'];
    this.totalrecommendations = response['total_results'];
    this.recommendations = [];
    this
        .recommendations
        .addAll(fetchSimilarOrRecommendations(response, mediaType));
  }

  Future<void> getSimilar() async {
    if (similarpageidx >= similarpages && similarpages != -1) return;
    var response = await api.getSimilar(id, mediaType, similarpageidx++);
    this.similarpages = response['total_pages'];
    this.totalsimilar = response['total_results'];
    this.similar = [];
    this.similar.addAll(fetchSimilarOrRecommendations(response, mediaType));
  }

  Future<void> getImages() async {
    var response = await api.getImages(id, mediaType);
    this.posters = fetchImages(response, 'posters');
    this.backdrops = fetchImages(response, 'backdrops');
  }

  Future<void> getVideos() async {
    var response = await api.getVideos(id, mediaType);
    this.videos = fetchVideos(response);
    downloadedVideos = true;
    for (int i = 0; i < videos.length; i++) {
      if (videos[i].site == 'YouTube' && videos[i].type == 'Trailer') {
        trailer = videos[i];
        break;
      }
    }
  }
}

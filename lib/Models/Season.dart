import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';

import '../Constants.dart';
import '../Helper.dart';
import 'Episode.dart';

class Season {
  String id, number, name, overview, airdate, episodecount, posterurl, tvid;
  List<MediaImage> images;
  List<MediaVideo> videos;
  List<Episode> episodes;
  MediaVideo trailer;
  Season({
    this.tvid,
    this.id,
    this.number,
    this.name,
    this.overview,
    this.airdate,
    this.episodecount,
    this.posterurl,
    this.images,
    this.videos,
    this.episodes,
  });
  Future<void> getImages() async {
    var response = await api.getSeasonImages(tvid, number);
    this.images = [];
    this.images = fetchImages(response, 'posters');
  }

  Future<void> getVideos() async {
    var response = await api.getSeasonVideos(tvid, number);
    this.videos = [];
    this.videos = fetchVideos(response);
    for (int i = 0; i < videos.length; i++) {
      if (videos[i].site == 'YouTube' && videos[i].type == 'Trailer') {
        trailer = videos[i];
        break;
      }
    }
  }
}

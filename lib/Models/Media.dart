import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  }) {
    recommendationspageidx = 1;
    similarpageidx = 1;
    similarpages = -1;
    recommendationspages = -1;
    // similar = [];
    // recommendations = [];
    totalsimilar = -1;
    totalrecommendations = -1;
    // cast = [];
    // crew = [];
    // posters = [];
    // backdrops = [];
    // videos = [];
    downloadedCredits = false;
    // downloadedVideos = false;
    // trailer = new MediaVideo(id: '-1', key: '-1', site: 'youtube');
  }
  Future<void> getCredits() async {
    var response = await api.getCredits(id, mediaType);
    this.cast = fetchCredits(response, 'cast');
    this.crew = fetchCredits(response, 'crew');
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

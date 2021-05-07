import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/Models/Season.dart';
import 'Models/Episode.dart';
import 'Models/Media.dart';
import 'Models/Movie.dart';
import 'Models/TvShow.dart';
import 'Network.dart';

List<Media> fetchSimilarOrRecommendations(var response, String mediaType) {
  List<Media> ans = [];
  for (int i = 0; i < (response['results']).length; i++)
    ans.add(toMediaBasic(response['results'][i], mediaType));
  return ans;
}

List<MediaVideo> fetchVideos(var response) {
  List<MediaVideo> ans = [];
  List<dynamic> mp = response['results'];
  for (int i = 0; i < mp.length; i++)
    ans.add(
      new MediaVideo(
        id: mp[i]['id'].toString(),
        key: mp[i]['key'].toString(),
        site: mp[i]['site'].toString(),
        name: mp[i]['name'].toString(),
        type: mp[i]['type'].toString(),
      ),
    );
  return ans;
}

List<MediaImage> fetchImages(var response, String type) {
  List<dynamic> mp = response[type];
  List<MediaImage> ans = [];
  for (int i = 0; i < mp.length; i++)
    ans.add(new MediaImage(
      path: Network.imgbaseurlw780 + mp[i]['file_path'].toString(),
      aspectRatio: mp[i]['aspect_ratio'].toString(),
      width: mp[i]['width'].toString(),
      height: mp[i]['height'].toString(),
    ));
  return ans;
}

List<Person> fetchCredits(var response, String type) {
  List<Person> ans = [];

  List<dynamic> mp = response[type];
  for (int i = 0; i < mp.length; i++) {
    ans.add(
      new Person(
        id: mp[i]['id'].toString(),
        name: mp[i]['name'].toString(),
        profileImgUrl:
            Network.imgbaseurlw185 + mp[i]['profile_path'].toString(),
        character: (type == 'cast') ? mp[i]['character'].toString() : '',
        job: (type == 'crew') ? mp[i]['job'].toString() : '',
      ),
    );
  }
  return ans;
}

List<String> fetchGenres(var response) {
  List<dynamic> mp = response['genres'];
  List<String> genres = [];

  for (int i = 0; i < mp.length; i++) genres.add(mp[i]['name']);
  return genres;
}

Season toSeason(var response, String tvid) {
  return new Season(
    id: response['id'].toString(),
    airdate: response['air_date'].toString(),
    name: response['name'].toString(),
    overview: response['overview'].toString(),
    posterurl: Network.imgbaseurlw342 + response['poster_path'].toString(),
    number: response['season_number'].toString(),
    tvid: tvid,
    episodecount: (response['episodes']).length.toString(),
    episodes: fetchEpisodes(response),
  );
}

List<Episode> fetchEpisodes(var response) {
  List<dynamic> mp = response['episodes'];
  List<Episode> ans = [];
  for (int i = 0; i < mp.length; i++) {
    ans.add(new Episode(
      airdate: mp[i]['air_date'].toString(),
      id: mp[i]['id'].toString(),
      name: mp[i]['name'].toString(),
      overview: mp[i]['overview'].toString(),
      posterurl: mp[i]['still_path'].toString(),
      voteavg: mp[i]['vote_average'].toString(),
      votecount: mp[i]['vote_count'].toString(),
      number: mp[i]['episode_number'].toString(),
    ));
  }
  return ans;
}

List<Season> fetchSeasons(var response) {
  List<dynamic> mp = response['seasons'];
  List<Season> ans = [];
  for (int i = 0; i < mp.length; i++)
    ans.add(
      new Season(
        tvid: response['id'].toString(),
        airdate: mp[i]['air_date'].toString(),
        episodecount: mp[i]['episode_count'].toString(),
        id: mp[i]['id'].toString(),
        name: mp[i]['name'].toString(),
        overview: mp[i]['overview'].toString(),
        posterurl: Network.imgbaseurlw185 + mp[i]['poster_path'].toString(),
        number: mp[i]['season_number'].toString(),
      ),
    );
  return ans;
}

List<Media> toMediaList(var response, String mediaType) {
  List<Media> list = [];
  for (int i = 0; i < 20; i++)
    list.add(toMediaBasic(response['results'][i], mediaType));
  return list;
}

Media toMedia(var response, String mediaType) {
  String posterurl =
      Network.imgbaseurlw342 + response['poster_path'].toString();
  String backdropurl =
      Network.imgbaseurlw780 + response['backdrop_path'].toString();
  Media media = (mediaType == 'movie')
      ? new Movie(
          id: (response['id']).toString(),
          posterurl: posterurl,
          backdropurl: backdropurl,
          budget: response['budget'].toString(),
          revenue: response['revenue'].toString(),
          overview: response['overview'].toString(),
          releasedate: response['release_date'].toString(),
          runtime: response['runtime'].toString(),
          title: response['title'].toString(),
          status: response['status'].toString(),
          voteavg: response['vote_average'].toString(),
          votecount: response['vote_count'].toString(),
          genres: fetchGenres(response),
          imdbID: response['imdb_id'],
        )
      : new TvShow(
          id: (response['id']).toString(),
          posterurl: posterurl,
          backdropurl: backdropurl,
          overview: response['overview'].toString(),
          numberofepisodes: response['number_of_episodes'].toString(),
          numberofseasons: response['number_of_seasons'].toString(),
          releasedate: response['first_air_date'].toString(),
          status: response['status'].toString(),
          title: response['name'].toString(),
          voteavg: response['vote_average'].toString(),
          votecount: response['vote_count'].toString(),
          genres: fetchGenres(response),
          imdbID: response['imdb_id'],
          seasons: fetchSeasons(response),
        );
  return media;
}

Media toMediaBasic(var response, String mediaType) {
  String posterurl =
      Network.imgbaseurlw185 + (response['poster_path']).toString();
  Media media = (mediaType == 'movie')
      ? new Movie(
          id: (response['id']).toString(),
          posterurl: posterurl,
          releasedate: response['release_date'].toString(),
          title: response['title'].toString(),
          voteavg: response['vote_average'].toString(),
        )
      : new TvShow(
          id: (response['id']).toString(),
          posterurl: posterurl,
          releasedate: response['first_air_date'].toString(),
          title: response['name'].toString(),
          voteavg: response['vote_average'].toString(),
        );
  return media;
}

String toHoursandMinutes(String len) {
  int minutes;
  String ans = '';
  try {
    minutes = int.parse(len);
  } catch (e) {
    print('error parsing string to int');
  }
  int h = minutes ~/ 60, m = minutes - 60 * h;
  if (h > 0) ans += h.toString() + 'h';
  if (h > 0 && m > 0) ans += ' ';
  if (m > 0) ans += m.toString() + 'm';
  return ans;
}

String splitByDots(List<String> list) {
  String ans = '';
  ans += list.first;
  for (int i = 1; i < list.length; i++) ans += ' . ' + list[i];
  return ans;
}

void navigatePush(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void navigatePushOnly(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => false,
  );
}
/*
?Trailer URL
?Just add the Key in the respective URL:
?YouTube: https://www.youtube.com/watch?v=
?Vimeo: https://vimeo.com/
*/

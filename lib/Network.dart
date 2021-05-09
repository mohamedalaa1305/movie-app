import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/Helper.dart';

class Network {
  static const String apikey = '?api_key=6df06c7ba764015fcbf426ac8857a052';
  static const String domain = 'https://api.themoviedb.org/3/';
  static const String imgbaseurlw92 = 'https://image.tmdb.org/t/p/w92';
  static const String imgbaseurlw154 = 'https://image.tmdb.org/t/p/w154';
  static const String imgbaseurlw185 = 'https://image.tmdb.org/t/p/w185';
  static const String imgbaseurlw342 = 'https://image.tmdb.org/t/p/w342';
  static const String imgbaseurlw500 = 'https://image.tmdb.org/t/p/w500';
  static const String imgbaseurlw780 = 'https://image.tmdb.org/t/p/w780';
  static const String imgbaseurloriginal =
      'https://image.tmdb.org/t/p/original';

  final List<String> mediaTypes = ['movie', 'tv', 'person'];
  final List<String> trendingTimes = ['day', 'week'];

  Future getDetails(String id, String mediaType) async {
    final String url = domain + mediaType + "/" + id + apikey;
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getCredits(String id, String mediaType) async {
    final String url = domain + mediaType + '/' + id + '/credits' + apikey;
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getImages(String id, String mediaType) async {
    final String url = domain + mediaType + '/' + id + '/images' + apikey;
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getVideos(String id, String mediaType) async {
    final String url = domain + mediaType + '/' + id + '/videos' + apikey;
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getSimilar(String id, String mediaType, int page) async {
    final String url = domain +
        mediaType +
        '/' +
        id +
        '/similar' +
        apikey +
        '&page=' +
        page.toString();
    print("url = " + url);
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getRecommendations(
      String id, String mediaType, int page) async {
    final String url = domain +
        mediaType +
        '/' +
        id +
        '/recommendations' +
        apikey +
        '&page=' +
        page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getTrending(
      String mediaType, String trendingTime, int page) async {
    if (!mediaTypes.contains(mediaType) ||
        !trendingTimes.contains(trendingTime))
      throw Exception('invalid media type or trending time');
    final String url = domain +
        "trending/" +
        mediaType +
        "/" +
        trendingTime +
        apikey +
        "&page=" +
        page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  //popularMovies: popularMovies, upcomingMovies: upcomingMovies, nowPlayingMovies: nowPlayingMovies, topRatedMovies: topRatedMovies
  Future<dynamic> getPopular(String mediaType, int page) async {
    if (!mediaTypes.contains(mediaType))
      throw Exception('invalid media type or trending time');
    // final String url =
    //     domain + mediaType + "/popular/" + apikey + "&page=" + page.toString();
    String count = (mediaType == 'movie') ? '7500' : '500';
    final url = '$domain' +
        'discover/$mediaType$apikey' +
        '&sort_by=popularity.desc&vote_count.gte=$count' +
        '&page=${page.toString()}';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getTopRated(String mediaType, int page) async {
    if (!mediaTypes.contains(mediaType))
      throw Exception('invalid media type or trending time');
    // final String url = domain +
    //     mediaType +
    //     "/top_rated/" +
    //     apikey +
    //     "&page=" +
    //     page.toString();
    String count = (mediaType == 'movie') ? '5000' : '1000';
    String ex = '&without_genres=16';
    final String url = '$domain' +
        'discover/$mediaType$apikey&sort_by=vote_average.desc&page=${page.toString()}&vote_count.gte=$count$ex';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getNowPlaying(int page) async {
    String mediaType = 'movie';
    final String url = domain +
        mediaType +
        "/now_playing/" +
        apikey +
        "&page=" +
        page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getUpcoming(int page) async {
    // String mediaType = 'movie';
    // final String url =
    //     domain + mediaType + "/upcoming/" + apikey + "&page=" + page.toString();
    final url = '$domain' +
        'discover/movie$apikey' +
        '&sort_by=primary_release_date.asc' +
        '&page=${page.toString()}&primary_release_date.gte=${getCurrentDate()}';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getOnTv(int page) async {
    String mediaType = 'tv';
    final String url = domain +
        mediaType +
        "/on_the_air/" +
        apikey +
        "&page=" +
        page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getAiringToday(int page) async {
    //? getting netflix shows instead
    // String mediaType = 'tv';
    // final String url = domain +
    //     mediaType +
    //     "/airing_today/" +
    //     apikey +
    //     "&page=" +
    //     page.toString();
    final String url = '$domain' +
        'discover/tv$apikey&sort_by=popularity.desc&with_networks=213&page=${page.toString()}';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> search(String mediaType, String query, int page) async {
    final String url = domain +
        'search/$mediaType$apikey&query=$query&page=${page.toString()}';
    print("url = " + url);
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getSeason(String tvid, String number) async {
    final String url = domain + 'tv/' + tvid + '/season/' + number + apikey;
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getSeasonImages(String tvid, String number) async {
    final String url = '$domain' + 'tv/' + '$tvid/season/$number/images$apikey';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getPersonImages(String id) async {
    final String url = '$domain' + 'person/' + '$id/images$apikey';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getPersonCredits(String id) async {
    final String url = '$domain' + 'person/' + '$id/combined_credits$apikey';
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }

  Future<dynamic> getSeasonVideos(String tvid, String number) async {
    final String url = '$domain' + 'tv/' + '$tvid/season/$number/videos$apikey';
    // print('url = ' + url);
    var response = await http.get(url);
    if (response.statusCode == 200) return convert.jsonDecode(response.body);
    return null;
  }
}

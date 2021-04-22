import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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

  Future getMovie(String id) async {
    final String url = domain + "movie/" + id + apikey;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else
      return null;
  }

  Future<dynamic> getTrending(
      String mediaType, String trendingTime, int page) async {
    print("getting trending from network");
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
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
  }

  //popularMovies: popularMovies, upcomingMovies: upcomingMovies, nowPlayingMovies: nowPlayingMovies, topRatedMovies: topRatedMovies
  Future<dynamic> getPopular(String mediaType, int page) async {
    print("getting popular from network");
    if (!mediaTypes.contains(mediaType))
      throw Exception('invalid media type or trending time');
    final String url =
        domain + mediaType + "/popular/" + apikey + "&page=" + page.toString();
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> getTopRated(String mediaType, int page) async {
    if (!mediaTypes.contains(mediaType))
      throw Exception('invalid media type or trending time');
    final String url = domain +
        mediaType +
        "/top_rated/" +
        apikey +
        "&page=" +
        page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
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
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> getUpcoming(int page) async {
    String mediaType = 'movie';
    final String url =
        domain + mediaType + "/upcoming/" + apikey + "&page=" + page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
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
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
  }

  Future<dynamic> getAiringToday(int page) async {
    String mediaType = 'tv';
    final String url = domain +
        mediaType +
        "/airing_today/" +
        apikey +
        "&page=" +
        page.toString();
    var response = await http.get(url);
    if (response.statusCode == 200)
      return convert.jsonDecode(response.body);
    else {
      print(response.statusCode);
      return null;
    }
  }
  // Future<dynamic> getTrendingTvShows(
  //     String mediaType, String trendingTime, int page) async {
  //   if (!mediaTypes.contains(mediaType) ||
  //       !trendingTimes.contains(trendingTime))
  //     throw Exception('invalid media type or trending time');
  //   final String url = trending +
  //       mediaType +
  //       "/" +
  //       trendingTime +
  //       apikey +
  //       "&page=" +
  //       page.toString();
  //   var response = await http.get(url);
  //   if (response.statusCode == 200)
  //     return convert.jsonDecode(response.body);
  //   else {
  //     print(response.statusCode);
  //     return null;
  //   }
  // }
}

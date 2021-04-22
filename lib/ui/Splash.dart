import 'package:flutter/material.dart';
import 'package:movie_app/DataController.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dc = Provider.of<DataController>(context, listen: false);
    loadHomePage(context, dc);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/tmdb3s.jpg'),
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
      ),
    );
  }

  void loadHomePage(BuildContext context, DataController dc) async {
    await dc.getTrending('movie', 'week');
    await dc.getTrending('tv', 'week');
    await dc.getPopular('movie');
    await dc.getPopular('tv');
    await dc.getTopRated('movie');
    await dc.getTopRated('tv');
    await dc.getNowPlaying();
    await dc.getUpcoming();
    await dc.getAiringToday();
    await dc.getOnTv();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
      (route) => false,
    );
  }
}

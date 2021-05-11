import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'HomeScreen.dart';
import 'TestingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    preProcess();
    Future.delayed(Duration(seconds: 1, microseconds: 750), () {
      Get.off(Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme[background],
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/splashimage.png'),
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
      ),
    );
  }

  Future<void> preProcess() async {
    movieGenres = fetchGenreList(await api.getGenres('movie'));
    tvGenres = fetchGenreList(await api.getGenres('tv'));
    print("genres len = " + movieGenres.length.toString());
  }
}

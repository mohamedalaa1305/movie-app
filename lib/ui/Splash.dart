import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/ui/TestingScreen.dart';
import 'Home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.off(Home());
    });
  }

  @override
  Widget build(BuildContext context) {
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/Constants.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
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
}

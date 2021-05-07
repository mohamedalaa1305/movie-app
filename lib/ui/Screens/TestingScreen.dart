import 'package:flutter/material.dart';
import 'package:movie_app/Templates/VideoPlayerWidget.dart';
import '../../Constants.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kplatte1[1],
      body: Center(
        child: Container(
          // height: 500,
          // width: 300,
          child: VideoPlayerWidget(
            url: 'w8Pr9V2M-rE',
          ),
        ),
      ),
    );
  }
}

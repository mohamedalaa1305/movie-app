import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';

class Loading extends StatelessWidget {
  final height;
  const Loading({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: loading,
    );
  }
}

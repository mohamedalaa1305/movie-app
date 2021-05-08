import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';

class Loading extends StatelessWidget {
  final double height;
  const Loading({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 180.0,
      child: loading,
    );
  }
}

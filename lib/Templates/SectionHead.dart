import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';

class SectionHead extends StatelessWidget {
  final Widget child;
  final String title;
  const SectionHead({Key key, @required this.child, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: kSectionTitleTextStyle,
            ),
          ),
        child,
      ],
    );
  }
}

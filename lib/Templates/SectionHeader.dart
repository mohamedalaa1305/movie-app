import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/ui/Home.dart';
import 'package:movie_app/ui/MediaScreen.dart';

class SectionHeader extends StatelessWidget {
  final String title, mediaType;
  final int tabIndex;
  const SectionHeader(
      {Key key,
      @required this.title,
      @required this.tabIndex,
      @required this.mediaType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      // margin: EdgeInsets.only(right: 8, left: 8),
      // padding: EdgeInsets.all(2),
      // color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.only(left: 8, right: 8),
              color: Kplatte1[0],
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.abel().fontFamily,
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                tooltip: 'see all',
                onPressed: () => navigatePush(
                  context,
                  MediaScreen(
                    mediaType: mediaType,
                    tabIndex: tabIndex,
                  ),
                ),
                color: Colors.white54,
                icon: Icon(Icons.arrow_forward),
                iconSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

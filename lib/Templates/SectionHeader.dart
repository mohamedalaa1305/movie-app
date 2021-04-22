import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';


class SectionHeader extends StatelessWidget {
  final String title;
  final int tabIndex;
  const SectionHeader({Key key, @required this.title, this.tabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, left: 8),
      decoration: BoxDecoration(
        color: Kplatte1[1],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.abel().fontFamily,
              fontSize: 18,
              // fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: Colors.white,
            ),
            // ),
          ),
          Row(
            children: [
              // Text(
              //   'see all',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontFamily: GoogleFonts.abel().fontFamily,
              //   ),
              // ),
              IconTheme(
                data: IconThemeData(
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.arrow_right_sharp),
          //   color: Colors.white,
          // )
        ],
      ),
    );
  }
}

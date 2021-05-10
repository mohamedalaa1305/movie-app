import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../Constants.dart';
class OverviewContainer extends StatelessWidget {
  final overview;
  const OverviewContainer({
    @required this.overview,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      child: ReadMoreText(
        overview,
        trimLines: 4,
        trimMode: TrimMode.Length,
        trimCollapsedText: 'more',
        trimExpandedText: 'less',
        moreStyle: GoogleFonts.abel().copyWith(
          color: appTheme[readMore],
          fontSize: 13,
        ),
        lessStyle: GoogleFonts.abel().copyWith(
          color: appTheme[readMore],
          fontSize: 13,
        ),
        style: GoogleFonts.abel().copyWith(
          color: appTheme[txt],
          fontSize: 14,
        ),
      ),
    );
  }
}
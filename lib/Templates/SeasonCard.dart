import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Season.dart';
import 'package:movie_app/Models/TvShow.dart';
import 'package:movie_app/ui/Screens/SeasonScreen.dart';

import '../Constants.dart';

class SeasonCard extends StatelessWidget {
  final Season season;
  final TvShow show;
  const SeasonCard({
    Key key,
    @required this.season,
    this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      child: IntrinsicWidth(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: (MediaQuery.of(context).size.width * 0.22) / 0.67,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: season.posterurl,
                        placeholder: (_, __) =>
                            Image.asset(KPortraitPlaceHolder),
                        errorWidget: (_, __, ___) =>
                            Image.asset(KPortraitPlaceHolder),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    bottom: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: appTheme[background],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        season.airdate.substring(0, 4),
                        style: GoogleFonts.abel().copyWith(
                          color: appTheme[txt],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          navigatePush(
                            context,
                            SeasonScreen(
                              id: season.id,
                              number: season.number,
                              show: show,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 2),
              child: Text(
                season.name,
                style: GoogleFonts.abel().copyWith(
                  color: appTheme[txt],
                  fontSize: 13,
                ),
                // textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 2),
              child: Text(
                season.episodecount + ' Episodes',
                style: GoogleFonts.abel().copyWith(
                  color: appTheme[subText],
                  fontSize: 11,
                ),
                // textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

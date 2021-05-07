import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Models/Season.dart';

import '../Constants.dart';

class SeasonCard extends StatelessWidget {
  final Season season;
  const SeasonCard({Key key, @required this.season}) : super(key: key);

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
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          // navigatePush(
                          //   context,
                          //   // SeasonScreen(),
                          // );
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
                  color: Colors.white,
                  fontSize: 12,
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
                  color: Colors.white,
                  fontSize: 12,
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

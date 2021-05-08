import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/ui/Screens/MovieScreen.dart';
import 'package:movie_app/ui/Screens/TvShowScreen.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  final String info;
  const MediaCard({@required this.media, this.info});
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
                        imageUrl: media.posterurl,
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
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Kplatte1[1],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (media.releasedate != null &&
                                media.releasedate.length > 3)
                            ? media.releasedate.substring(0, 4)
                            : 'Unknown',
                        style: GoogleFonts.abel().copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Kplatte1[1],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        double.parse(media.voteavg).toStringAsPrecision(2),
                        style: GoogleFonts.abel().copyWith(
                          color: Colors.white,
                          fontSize: 10,
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
                            (media.mediaType == 'movie')
                                ? MovieScreen(id: media.id, title: media.title)
                                : TvShowScreen(
                                    id: media.id,
                                    title: media.title,
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
                media.title,
                style: GoogleFonts.abel().copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
                // textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            (info != null)
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    // alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 2),
                    child: Text(
                      info,
                      style: GoogleFonts.abel().copyWith(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                      // textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/ui/MediaDetails.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  const MediaCard({@required this.media});
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
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          navigatePush(
                            context,
                            MediaDetails(
                              id: media.id,
                              title: media.title,
                              mediaType: media.mediaType,
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
          ],
        ),
      ),
    );
  }
}

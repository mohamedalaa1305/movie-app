import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/ui/MediaDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediaGridPosterConatainer extends StatelessWidget {
  final Media media;
  final double width;
  MediaGridPosterConatainer({
    @required this.media,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: width,
            height: width / 0.67,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset('assets/images/def3.png'),
                      errorWidget: (context, posterUrl, error) =>
                          Image.asset('assets/images/def3.png'),
                      imageUrl: media.posterurl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: Kplatte1[1],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        double.parse(media.voteavg).toPrecision(1).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: GoogleFonts.robotoSlab().fontFamily,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: Kplatte1[1],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        (media.releasedate.isBlank)
                            ? 'unknown'
                            : media.releasedate.substring(0, 4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.robotoSlab().fontFamily,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      onTap: () {
                        Get.to(
                          () => MediaDetails(
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
            child: Center(
              child: AutoSizeText(
                media.title,
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                // minFontSize: 10,
                // maxFontSize: 14,
                // textScaleFactor: 0.8,
                wrapWords: false,
                // softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
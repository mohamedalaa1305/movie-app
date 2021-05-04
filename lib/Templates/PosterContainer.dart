import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/ui/MediaDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PosterConatainer extends StatelessWidget {
  final Media media;
  final double width;
  PosterConatainer({
    @required this.media,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.25 / 0.67,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset(KPortraitPlaceHolder),
                      errorWidget: (context, url, error) =>
                          Image.asset(KPortraitPlaceHolder),
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
                        media.voteavg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: GoogleFonts.robotoSlab().fontFamily,
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
                          fontSize: 11,
                          fontFamily: GoogleFonts.robotoSlab().fontFamily,
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
            // width: MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: AutoSizeText(
                media.title,
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                wrapWords: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

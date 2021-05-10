import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/ui/Screens/ImagePlayerScreen.dart';
import '../Constants.dart';
import '../Helper.dart';

class Images extends StatelessWidget {
  final String posterUrl, backdropUrl;
  final List<MediaImage> posters, backdrops;
  const Images({
    Key key,
    @required this.posterUrl,
    @required this.backdropUrl,
    @required this.posters,
    @required this.backdrops,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 48) * 0.3,
            height: (MediaQuery.of(context).size.width - 48) * 0.3 / 0.67,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: posterUrl,
                      placeholder: (_, __) => Image.asset(KPortraitPlaceHolder),
                      errorWidget: (_, __, ___) =>
                          Image.asset(KPortraitPlaceHolder),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: appTheme[background],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      posters.length.toString() + ' Posters',
                      style: GoogleFonts.abel().copyWith(
                        color: appTheme[txt],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
                        if (posters == null || posters.isEmpty) return;
                        navigatePush(
                          context,
                          ImagePlayerScreen(
                            images: posters,
                            landscape: false,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 48) * 0.7,
            height: (MediaQuery.of(context).size.width - 48) * 0.3 / 0.67,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: backdropUrl,
                      placeholder: (_, __) =>
                          Image.asset(KLandscapePlaceHolder),
                      errorWidget: (_, __, ___) =>
                          Image.asset(KLandscapePlaceHolder),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: appTheme[background],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      backdrops.length.toString() + ' Backdrops',
                      style: GoogleFonts.abel().copyWith(
                        color: appTheme[txt],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if (backdrops == null || backdrops.isEmpty) return;
                        navigatePush(
                          context,
                          ImagePlayerScreen(
                            images: backdrops,
                            landscape: true,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Templates/IconText.dart';
import 'package:movie_app/ui/Screens/VideoPlayerScreen.dart';

class CustomFlexibleSpaceBar extends StatelessWidget {
  final BuildContext parentcontext;
  final BoxConstraints constraints;
  final String title,
      backdropUrl,
      posterUrl,
      line1,
      line2,
      line3,
      rating,
      voteCount,
      trailerUrl,
      mediaType;
  const CustomFlexibleSpaceBar({
    Key key,
    @required this.parentcontext,
    @required this.constraints,
    @required this.title,
    @required this.backdropUrl,
    @required this.posterUrl,
    @required this.rating,
    @required this.voteCount,
    @required this.line1,
    @required this.line2,
    @required this.line3,
    @required this.trailerUrl,
    this.mediaType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      titlePadding: EdgeInsets.only(left: 60, bottom: 16, right: 60, top: 16),
      title: (constraints.biggest.height ==
              MediaQuery.of(context).padding.top + kToolbarHeight)
          ? Text(
              title,
              style: GoogleFonts.abel().copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      background: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 1.7,
            child: CachedNetworkImage(
              placeholder: (_, __) => Image.asset(KLandscapePlaceHolder),
              errorWidget: (_, __, ___) => Image.asset(KLandscapePlaceHolder),
              imageUrl: backdropUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.7 * 0.8),
            left: 16,
            width: MediaQuery.of(context).size.width * 0.265,
            height: (MediaQuery.of(context).size.width * 0.265) / 0.67,
            child: Container(
              constraints: BoxConstraints.expand(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  placeholder: (_, __) => Image.asset(KPortraitPlaceHolder),
                  errorWidget: (_, __, ___) =>
                      Image.asset(KPortraitPlaceHolder),
                  imageUrl: posterUrl,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: (MediaQuery.of(context).size.width / 1.7 * 0.8) +
                (MediaQuery.of(context).size.width * 0.265) / 0.67 +
                4,
            width: MediaQuery.of(context).size.width * 0.265,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconText(txt: voteCount, icon: Icons.people_alt),
                IconText(txt: rating, icon: Icons.star_rate_rounded),
              ],
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.7 * 0.8) +
                (MediaQuery.of(context).size.width * 0.265) / 0.67 +
                22,
            width: MediaQuery.of(context).size.width * 0.265,
            left: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Image.asset('assets/images/tmdblogo.png'),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width / 1.7 + 12,
            left: 16 + MediaQuery.of(context).size.width * 0.265 + 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.abel().copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.list_rounded,
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      line1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.abel().copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      line2,
                      style: GoogleFonts.abel().copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      (mediaType == 'movie')
                          ? Icons.access_time
                          : Icons.tv_rounded,
                      color: Colors.white,
                      size: 13,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      line3,
                      style: GoogleFonts.abel().copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 16,
            width: MediaQuery.of(context).size.width * 0.28,
            height: MediaQuery.of(context).size.height * 0.04,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.cyan[600],
              ),
              padding: EdgeInsets.only(right: 8),
              child: IconTheme(
                data: IconThemeData(color: Colors.white, size: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      (trailerUrl != 'null')
                          ? Icons.play_arrow_rounded
                          : Icons.error,
                    ),
                    AutoSizeText(
                      (trailerUrl != 'null') ? 'Play Trailer' : 'No Trailer',
                      style: GoogleFonts.abel().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      minFontSize: 14,
                      maxFontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 16,
            width: MediaQuery.of(context).size.width * 0.28,
            height: MediaQuery.of(context).size.height * 0.04,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  if (trailerUrl != 'null')
                    navigatePush(context, VideoPlayerScreen(url: trailerUrl));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

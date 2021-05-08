import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Models/Episode.dart';
import 'package:movie_app/Templates/IconText.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  const EpisodeCard({Key key, @required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      color: Colors.black26,
                    ),
                    child: Text(
                      episode.number + '. ' + episode.name,
                      style: GoogleFonts.abel().copyWith(
                        color: Colors.transparent,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: episode.posterurl,
                      placeholder: (_, __) =>
                          Image.asset(KLandscapePlaceHolder),
                      errorWidget: (_, __, ___) =>
                          Image.asset(KLandscapePlaceHolder),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Colors.black26,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconText(
                          txt: episode.votecount,
                          icon: Icons.people_alt_rounded,
                        ),
                        IconText(
                          txt: episode.voteavg,
                          icon: Icons.star_rate_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Kplatte1[1],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          episode.number + '. ' + episode.name,
                          style: GoogleFonts.abel().copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        episode.airdate,
                        style: GoogleFonts.abel().copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      episode.overview,
                      style: GoogleFonts.abel().copyWith(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: (episode.name.length > 20) ? 5 : 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

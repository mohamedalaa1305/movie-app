import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Controllers/MediaController.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/ui/Screens/ImagePlayer.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';
import '../Helper.dart';

class Images extends StatelessWidget {
  final data, mediaType;
  const Images({
    Key key,
    @required this.data,
    @required this.mediaType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    data.downloadImages(mediaType);
    return Selector<MediaController, List<MediaImage>>(
      selector: (_, data) => data.getBackdrops(mediaType),
      builder: (context, val, child) {
        return (val.isEmpty)
            ? loading
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('Images', style: kSectionTitleTextStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 8,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 48) * 0.3,
                          height: (MediaQuery.of(context).size.width - 48) *
                              0.3 /
                              0.67,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: data.getPosterUrl(mediaType),
                                    placeholder: (_, __) =>
                                        Image.asset(KPortraitPlaceHolder),
                                    errorWidget: (_, __, ___) =>
                                        Image.asset(KPortraitPlaceHolder),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                left: 8,
                                child: Text(
                                  data.getPosters(mediaType).length.toString() +
                                      ' Posters',
                                  style: GoogleFonts.abel().copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
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
                                        ImagePlayer(
                                          images: data.getPosters(mediaType),
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
                          height: (MediaQuery.of(context).size.width - 48) *
                              0.3 /
                              0.67,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: data.getBackdropUrl(mediaType),
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
                                child: Text(
                                  data
                                          .getBackdrops(mediaType)
                                          .length
                                          .toString() +
                                      ' Backdrops',
                                  style: GoogleFonts.abel().copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      navigatePush(
                                        context,
                                        ImagePlayer(
                                          images: data.getBackdrops(mediaType),
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
                  ),
                ],
              );
      },
    );
  }
}

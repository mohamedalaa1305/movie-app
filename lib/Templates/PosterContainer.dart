import 'package:flutter/material.dart';
import 'package:movie_app/ui/MovieDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/ui/TvShowDetails.dart';

class PosterConatainer extends StatelessWidget {
  // final Movie movie;
  final String id, mediaType, posterUrl;
  PosterConatainer(
      {@required this.id, @required this.mediaType, @required this.posterUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      // width: 95,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (mediaType == 'movie')
                        ? MovieDetails(id)
                        : TvShowDetails(id),
                  ),
                );
              },
              child: CachedNetworkImage(
                placeholder: (context, url) => Image(
                  image: AssetImage('assets/images/default.png'),
                ),
                imageUrl: posterUrl,
                fadeInDuration: Duration(milliseconds: 750),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

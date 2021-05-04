import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Controllers/MediaController.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import 'VideoPlayerWidget.dart';

class Videos extends StatelessWidget {
  final mediaType, data;
  const Videos({Key key, this.mediaType, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    data.downloadVideos(mediaType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Videos',
            style: kSectionTitleTextStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Selector<MediaController, bool>(
          selector: (_, __) => data.getDownloadedVideos(mediaType),
          builder: (context, downloaded, child) {
            if (downloaded && data.getVideos(mediaType).isEmpty) {
              return Container(
                height: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Text(
                    'No Thing To Show',
                    style: GoogleFonts.abel().copyWith(
                      color: Colors.white54,
                      fontSize: 24,
                    ),
                  ),
                ),
              );
            } else if (!downloaded) return Container(child: loading);
            return Container(
              height: (MediaQuery.of(context).size.width - 16) * 0.3 / 0.6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.only(left: 16, top: 8, bottom: 40, right: 16),
                itemCount: data.getVideos(mediaType).length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: (MediaQuery.of(context).size.width - 16) * 0.65,
                  margin: EdgeInsets.only(right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoPlayerWidget(
                        url: data.getVideos(mediaType)[index].key),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

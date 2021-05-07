import 'package:flutter/material.dart';
import 'package:movie_app/Models/MediaVideo.dart';
import 'VideoPlayerWidget.dart';

class Videos extends StatelessWidget {
  final List<MediaVideo> videos;
  const Videos({Key key, @required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 16) * 0.3 / 0.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 40, right: 16),
        itemCount: videos.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: (MediaQuery.of(context).size.width - 16) * 0.65,
          margin: EdgeInsets.only(right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: VideoPlayerWidget(url: videos[index].key),
          ),
        ),
      ),
    );
  }
}

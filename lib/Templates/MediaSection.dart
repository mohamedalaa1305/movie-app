import 'package:flutter/material.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Templates/MediaCard.dart';

class MediaSection extends StatelessWidget {
  final List<Media> media;
  final Function loadNext;
  const MediaSection({Key key, @required this.media, this.loadNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = ScrollController();
    // _controller.addListener(() async {
    //   if (_controller.position.maxScrollExtent == _controller.position.pixels) {
    //     await loadNext();
    //   }
    // });
    return Container(
      height: MediaQuery.of(context).size.height * 0.235,
      child: ListView.builder(
        primary: false,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: media.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: MediaCard(media: media[index]),
        ),
      ),
    );
  }
}

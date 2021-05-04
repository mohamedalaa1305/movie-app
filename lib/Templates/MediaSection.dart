import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Templates/MediaCard.dart';
import '../Constants.dart';

class MediaSection extends StatelessWidget {
  final sectinoTitle, hasData;
  final List<Media> media;
  final Function loadNext;
  const MediaSection(
      {Key key,
      this.sectinoTitle,
      @required this.media,
      this.loadNext,
      this.hasData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = ScrollController();
    _controller.addListener(() async {
      if (_controller.position.maxScrollExtent - _controller.position.pixels <=
          200) {
        await loadNext(media[0].mediaType);
      }
    });
    return Container(
      // margin: EdgeInsets.only(top: 8),
      // height: MediaQuery.of(context).size.height * 0.28,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              sectinoTitle,
              textAlign: TextAlign.start,
              style: kSectionTitleTextStyle,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.235,
            child: buildBody(hasData, _controller),
          ),
        ],
      ),
    );
  }

  void controllerListner() async {}

  Widget buildBody(hasData, _controller) {
    if (!hasData)
      return Center(
        child: Text(
          'No Thing To Show',
          style: GoogleFonts.abel().copyWith(
            color: Colors.white54,
            fontSize: 24,
          ),
        ),
      );
    return ListView.builder(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: media.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: MediaCard(media: media[index]),
      ),
    );
  }
}

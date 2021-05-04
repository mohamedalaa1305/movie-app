import 'package:flutter/material.dart';
import 'package:movie_app/Controllers/MediaController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'MediaSection.dart';

class MediaSelectorSection extends StatelessWidget {
  const MediaSelectorSection({
    Key key,
    this.sectionTitle,
    this.mediaType,
    this.watch,
    this.loadNext,
    this.watchx,
  }) : super(key: key);

  final String mediaType, sectionTitle;
  final Function watch, watchx, loadNext;
  @override
  Widget build(BuildContext context) {
    return Selector<MediaController, Tuple2<List<Media>, int>>(
      selector: (_, data) => Tuple2(watch(mediaType), watchx(mediaType)),
      builder: (context, sel, child) {
        if (sel.item1.isEmpty) {
          if (sel.item2 == -1) {
            loadNext(mediaType);
            return Container(
              height: MediaQuery.of(context).size.height * 0.235,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
        return MediaSection(
          sectinoTitle: sectionTitle,
          media: watch(mediaType),
          loadNext: loadNext,
          hasData: (sel.item2 != 0),
        );
      },
    );
  }
}

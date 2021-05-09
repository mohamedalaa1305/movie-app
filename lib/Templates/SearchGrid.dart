import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_app/Models/Media.dart';

import 'MediaGridPosterContainer.dart';

class SearchGrid extends StatelessWidget {
  final List<Media> media;
  final Function loadNext;
  const SearchGrid({Key key, this.media, this.loadNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ctrl = ScrollController();
    ctrl.addListener(() {
      if (ctrl.position.maxScrollExtent == ctrl.position.pixels ) {
        loadNext('');
      }
    });
    return GridView.count(
      primary: false,
      controller: ctrl,
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      crossAxisSpacing: 8,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      childAspectRatio: 0.53,
      children: List.generate(
        media.length,
        (idx) => MediaGridPosterConatainer(
          width: (MediaQuery.of(context).size.width - 32) * 0.33,
          media: media[idx],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/DataController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:provider/provider.dart';

import 'PosterContainer.dart';

class MediaGrid extends StatefulWidget {
  final String mediaType;
  final int tabIndex;
  MediaGrid({Key key, @required this.mediaType, @required this.tabIndex})
      : super(key: key);

  @override
  _MediaGridState createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  var _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(controllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dc = Provider.of<DataController>(context);
    return Scrollbar(
      thickness: 2,
      child: GridView.count(
        controller: _controller,
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        children: List.generate(
          dc.getList(widget.mediaType, widget.tabIndex).length,
          (idx) => PosterConatainer(
            id: dc.getList(widget.mediaType, widget.tabIndex)[idx].id,
            mediaType:
                dc.getList(widget.mediaType, widget.tabIndex)[idx].mediaType,
            posterUrl:
                dc.getList(widget.mediaType, widget.tabIndex)[idx].posterurl,
          ),
        ),
      ),
    );
  }

  void controllerListener() {
    if (_controller.position.atEdge && _controller.position.pixels != 0) {
      print('scrolling at end');
      final dc = Provider.of<DataController>(context, listen: false);
      print('initialization done');
      for (int i = 0; i < 2; i++)
        dc.loadNext(widget.mediaType, widget.tabIndex);
      print('done ok');
    }
  }
}

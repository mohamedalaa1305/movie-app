import 'package:flutter/material.dart';
import 'package:movie_app/Controllers/DataController.dart';
import 'package:provider/provider.dart';
import 'MediaGridPosterContainer.dart';

class MediaGrid extends StatefulWidget {
  final String mediaType;
  final int tabIndex;
  MediaGrid({Key key, this.mediaType, this.tabIndex}) : super(key: key);

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
    final dc = context.watch<DataController>();
    if (dc.getList(widget.mediaType, widget.tabIndex).isEmpty) {
      dc.loadNext(widget.mediaType, widget.tabIndex);
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GridView.count(
      primary: false,
      // shrinkWrap: true,
      controller: _controller,
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      crossAxisSpacing: 8,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      childAspectRatio: 0.53,
      children: List.generate(
        dc.getList(widget.mediaType, widget.tabIndex).length,
        (idx) => MediaGridPosterConatainer(
          width: (MediaQuery.of(context).size.width - 32) * 0.33,
          media: dc.getList(widget.mediaType, widget.tabIndex)[idx],
        ),
      ),
    );
  }

  void controllerListener() {
    if (_controller.position.maxScrollExtent == _controller.position.pixels) {
      final dc = context.read<DataController>();
      dc.loadNext(widget.mediaType, widget.tabIndex);
    }
  }
}

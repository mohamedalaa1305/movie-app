import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/DataController.dart';
import 'package:movie_app/Templates/PosterContainer.dart';
import 'package:movie_app/Templates/SectionHeader.dart';
import 'package:provider/provider.dart';

class HorizontalSection extends StatefulWidget {
  final String sectionTitle, mediaType;
  final int tabIndex;
  HorizontalSection({
    Key key,
    @required this.sectionTitle,
    @required this.mediaType,
    @required this.tabIndex,
  }) : super(key: key);

  @override
  _HorizontalSectionState createState() => _HorizontalSectionState();
}

class _HorizontalSectionState extends State<HorizontalSection> {
  var _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(controllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SectionHeader(
            title: widget.sectionTitle,
            mediaType: widget.mediaType,
            tabIndex: widget.tabIndex,
          ),
          Consumer<DataController>(
            builder: (_, data, __) {
              if (data.getList(widget.mediaType, widget.tabIndex).isEmpty) {
                data.loadNext(widget.mediaType, widget.tabIndex);
                return Container(
                  color: Kplatte1[0],
                  height: 205,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Container(
                color: Kplatte1[0],
                height: MediaQuery.of(context).size.width * 0.25 / 0.5,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 10),
                  controller: _controller,
                  itemCount:
                      data.getList(widget.mediaType, widget.tabIndex).length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int idx) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: PosterConatainer(
                        media: data.getList(
                            widget.mediaType, widget.tabIndex)[idx],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void controllerListener() {
    if (_controller.position.atEdge && _controller.position.pixels != 0) {
      final dc = context.read<DataController>();
      dc.loadNext(widget.mediaType, widget.tabIndex);
    }
  }
}

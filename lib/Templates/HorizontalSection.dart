import 'package:flutter/material.dart';
import 'package:movie_app/DataController.dart';
import 'package:movie_app/Templates/PosterContainer.dart';
import 'package:movie_app/Templates/SectionHeader.dart';
import 'package:movie_app/ui/MediaScreen.dart';
import 'package:provider/provider.dart';

class HorizontalSection extends StatefulWidget {
  final String sectionTitle, mediaType;
  final int tabIndex;
  const HorizontalSection({
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
    // final dc = Provider.of<DataController>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 0, left: 16, top: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MediaScreen(
                    mediaType: widget.mediaType,
                    tabIndex: widget.tabIndex,
                  ),
                ),
              );
            },
            child: SectionHeader(
              title: widget.sectionTitle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 150,
            child: Consumer<DataController>(
              builder: (_, data, __) {
                return ListView.builder(
                  controller: _controller,
                  itemCount:
                      data.getList(widget.mediaType, widget.tabIndex).length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int idx) {
                    return PosterConatainer(
                      id: data
                          .getList(widget.mediaType, widget.tabIndex)[idx]
                          .id,
                      mediaType: data
                          .getList(widget.mediaType, widget.tabIndex)[idx]
                          .mediaType,
                      posterUrl: data
                          .getList(widget.mediaType, widget.tabIndex)[idx]
                          .posterurl,
                    );
                  },
                );
              },
            ),
          ),
        ],
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

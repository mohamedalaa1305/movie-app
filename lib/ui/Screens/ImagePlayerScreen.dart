import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Models/MediaImage.dart';

class ImagePlayerScreen extends StatefulWidget {
  final List<MediaImage> images;
  final bool landscape;
  const ImagePlayerScreen({
    Key key,
    @required this.images,
    @required this.landscape,
  }) : super(key: key);

  @override
  _ImagePlayerScreenState createState() => _ImagePlayerScreenState();
}

class _ImagePlayerScreenState extends State<ImagePlayerScreen> {
  int idx = 1;
  @override
  void initState() {
    super.initState();
      SystemChrome.setEnabledSystemUIOverlays([]);
    // if (widget.landscape) {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.landscapeRight,
    //       DeviceOrientation.landscapeLeft,
    //     ]);
    // }
  }

  @override
  void deactivate() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // if (widget.landscape) {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //   ]);
    // }
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: 0, keepPage: true);
    return Scaffold(
      backgroundColor: appTheme[background],
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  idx = value + 1;
                });
              },
              controller: controller,
              children: buildPages(),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    idx.toString() + ' / ' + widget.images.length.toString(),
                    style: GoogleFonts.abel().copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPages() {
    List<Widget> pages = [];
    for (int i = 0; i < widget.images.length; i++) {
      Widget page = Container(
        constraints: BoxConstraints.expand(),
        child: CachedNetworkImage(
          imageUrl: widget.images[i].path,
          errorWidget: (_, __, ___) => Image.asset(KPortraitPlaceHolder),
          progressIndicatorBuilder: (context, url, progress) =>
              Center(child: CircularProgressIndicator()),
          fit: BoxFit.cover,
        ),
      );
      pages.add(page);
    }
    return pages;
  }
}

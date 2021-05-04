import 'package:flutter/cupertino.dart';

class MediaImage {
  String aspectRatio, path, width, height;
  MediaImage({
    @required this.path,
    @required this.aspectRatio,
    this.width,
    this.height,
  });
}

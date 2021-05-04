import 'package:flutter/cupertino.dart';

class MediaVideo {
  String id, key, name, type, site;
  MediaVideo({
    @required this.id,
    @required this.key,
    @required this.site,
    this.name,
    this.type,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final Duration seek;
  final bool hascontroller;
  final YoutubePlayerController yc;
  VideoPlayerScreen(
      {Key key, @required this.url, this.seek, this.hascontroller, this.yc})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController controller;
  IconData icon = Icons.play_arrow_rounded;
  String tooltip = 'play';
  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
      ),
    );

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void deactivate() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kplatte1[1],
      body: SafeArea(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          onReady: () {
            if (widget.seek != null) {
              print("seek = " + widget.seek.toString());
              controller.seekTo(widget.seek);
            }
            controller.addListener(() {
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}

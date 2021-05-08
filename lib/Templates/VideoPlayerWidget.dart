import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/ui/Screens/VideoPlayerScreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  VideoPlayerWidget({Key key, @required this.url}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController controller;
  IconData icon = Icons.play_arrow_rounded,
      screenstateicon = Icons.fullscreen_rounded;
  Duration startat;
  String tooltip = 'play';
  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            onReady: () => controller.addListener(() {
              setState(() {});
            }),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 8,
          child: Material(
            color: Kplatte1[1],
            type: MaterialType.button,
            child: InkWell(
              onTap: () => toggle(),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
                semanticLabel: tooltip,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 8,
          child: Material(
            type: MaterialType.button,
            color: Kplatte1[1],
            child: InkWell(
              onTap: () => fullscreen(),
              child: Icon(
                Icons.fullscreen_rounded,
                size: 20,
                color: Colors.white,
                semanticLabel: 'full screen',
              ),
            ),
          ),
        ),
      ],
    );
  }

  void toggle() {
    if (controller.value.isPlaying) {
      controller.pause();
      setState(() {
        icon = Icons.play_arrow_rounded;
        tooltip = 'play';
      });
    } else {
      controller.play();
      setState(() {
        icon = Icons.pause_rounded;
        tooltip = 'pause';
      });
    }
  }

  fullscreen() {
    toggle();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          url: widget.url,
          seek: controller.value.position,
        ),
      ),
    ).whenComplete(() {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    });
  }
}

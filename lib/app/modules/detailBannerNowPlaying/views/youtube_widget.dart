import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  YoutubePlayerWidget({super.key, required this.youtubeKey});

  final String youtubeKey;

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: YoutubePlayerFlags(
          autoPlay: false, mute: false, enableCaption: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      },
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.bottom,
            SystemUiOverlay.top,
          ],
        );
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      player: YoutubePlayer(controller: _controller),
      builder: (_, p1) {
        return p1;
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement didChangeDependencies
    _controller.dispose();
    super.dispose();
  }
}

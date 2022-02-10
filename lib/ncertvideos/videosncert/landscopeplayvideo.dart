import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LandscopePlayVideo extends StatefulWidget {
  const LandscopePlayVideo({required this.videoid});
  final String videoid;

  @override
  _LandscopePlayVideoState createState() => _LandscopePlayVideoState();
}

class _LandscopePlayVideoState extends State<LandscopePlayVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoid,
      params: YoutubePlayerParams(
          startAt: Duration(seconds: 5),
          showControls: true,
          showFullscreenButton: true,
          enableCaption: false,
          playsInline: true,
          autoPlay: true),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return Future.value(true);
      },
      child: YoutubePlayerControllerProvider(
        // Provides controller to all the widget below it.
        controller: _controller,

        child: YoutubePlayerIFrame(
          controller: _controller,
        ),
      ),
    );
  }
}

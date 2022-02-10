import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/ncertvideos/videosncert/landscopeplayvideo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayVideos extends StatefulWidget {
  final String videoid;
  const PlayVideos(this.videoid);

  @override
  _PlayVideosState createState() => _PlayVideosState();
}

class _PlayVideosState extends State<PlayVideos> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoid,
      params: YoutubePlayerParams(
          startAt: Duration(seconds: 5),
          showControls: true,
          showFullscreenButton: false,
          enableCaption: false,
          playsInline: true,
          autoPlay: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _controller.pause();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LandscopePlayVideo(videoid: widget.videoid),
                      ));
                },
                icon: Icon(Icons.screen_rotation_outlined))
          ],
        ),
        body: YoutubePlayerControllerProvider(
            // Provides controller to all the widget below it.
            controller: _controller,

            child: YoutubePlayerIFrame(
              controller: _controller,
            ),
          ),
       
      ),
    );
  }
}

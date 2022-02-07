import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NCERTPlaylist extends StatefulWidget {
  const NCERTPlaylist({Key? key}) : super(key: key);

  @override
  State<NCERTPlaylist> createState() => _NCERTPlaylistState();
}

class _NCERTPlaylistState extends State<NCERTPlaylist> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'K18cpp_-gP8',
      params: YoutubePlayerParams(
          playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
          startAt: Duration(seconds: 30),
          showControls: true,
          showFullscreenButton: true,
          playsInline: true,
          autoPlay: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/ncertvideos/Models/videolistapiservicemodel.dart';
import 'package:ncertclass1to12th/ncertvideos/apiservice/videolistapiservice.dart';
import 'package:ncertclass1to12th/ncertvideos/videosncert/playvideo.dart';

class PlaylistVideos extends StatefulWidget {
  const PlaylistVideos({required this.playlistId, required this.totalvideos});

  final String playlistId;
  final int totalvideos;

  @override
  State<PlaylistVideos> createState() => _PlaylistVideosState();
}

class _PlaylistVideosState extends State<PlaylistVideos> {
  ScrollController _controller = ScrollController();
  List<VideoAllPlaylistModel> videolist = [];
  bool _isLoading = false;

  _initVideolist(id) async {
    List<VideoAllPlaylistModel> allPlaylistModel =
        await VideoAPIService.instance.fetchVideosFromPlaylist(playlistId: id);
    setState(() {
      videolist = allPlaylistModel;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideolist(widget.playlistId);
  }

  _loadMoreVideos(id) async {
    print('call with ${videolist.length}');
    _isLoading = true;
    List<VideoAllPlaylistModel> moreVideos =
        await VideoAPIService.instance.fetchVideosFromPlaylist(playlistId: id);
    List<VideoAllPlaylistModel> updatedvideolist = videolist
      ..addAll(moreVideos);
    setState(() {
      videolist = updatedvideolist;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Videos'),
      ),
      body: videolist.length != 0
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    videolist.length != widget.totalvideos &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos(widget.playlistId);
                }
                return false;
              },
              child: ListView.builder(
                controller: _controller,
                itemCount: videolist.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayVideos(videolist[index].id),
                      ),
                    ),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 1),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //image
                          Container(
                            child: Container(
                              child: Image.network(
                                videolist[index].thumbnailUrl,
                              ),
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: AutoSizeText(
                                videolist[index].title,
                                minFontSize: 18,
                                maxLines: 3,
                              ),
                            ),
                          ),

                          //name
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}

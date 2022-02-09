import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ncertclass1to12th/ncertvideos/Models/videolistapiservicemodel.dart';
import 'package:ncertclass1to12th/ncertvideos/utilities/key.dart';

class VideoAPIService {
  VideoAPIService._instantiate();

  static final VideoAPIService instance = VideoAPIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<List<VideoAllPlaylistModel>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': YoutubeApiKeys.API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      int totalvideos = data['pageInfo']['totalResults'];
      print(data['pageInfo']['totalResults']);
      // Fetch first eight videos from uploads playlist
      List<VideoAllPlaylistModel> videos = [];
      for (var json in videosJson) {
        videos.add(
          VideoAllPlaylistModel.fromMap(json['snippet'], totalvideos),
        );
      }

      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}

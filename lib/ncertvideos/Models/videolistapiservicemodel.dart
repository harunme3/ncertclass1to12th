class VideoAllPlaylistModel {
  final String id;
  final String thumbnailUrl;
  final String title;
  final int totalvideos;

  VideoAllPlaylistModel({
    required this.id,
    required this.thumbnailUrl,
    required this.title,
    required this.totalvideos,
  });

  factory VideoAllPlaylistModel.fromMap(
      Map<String, dynamic> snippet, int totalvideos) {
    return VideoAllPlaylistModel(
      id: snippet['resourceId']['videoId'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      title: snippet['title'],
      totalvideos: totalvideos,
    );
  }
}

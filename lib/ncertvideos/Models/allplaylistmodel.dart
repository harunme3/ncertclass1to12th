class AllPlaylistModel {
  final int totalvideos;
  final String thumbnailUrl;
  final String channelTitle;
  final String playlistId;
  final String title;

  AllPlaylistModel({
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.totalvideos,
    required this.playlistId,
    required this.title,
  });

  factory AllPlaylistModel.fromMap(
      Map<String, dynamic> snippet, int totalvideos) {
    return AllPlaylistModel(
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      playlistId: snippet['playlistId'],
      totalvideos: totalvideos,
      title: snippet['title'],
    );
  }
}

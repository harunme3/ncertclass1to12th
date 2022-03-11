class BoardDataset {
  BoardDataset({required this.boardDataSet});

  factory BoardDataset.fromJson(Map<String, dynamic> data) {
    var list = data['board_dataset'] as List;
    List<BoardNameDataset> boardDataSetlist =
        list.map((e) => BoardNameDataset.fromJson(e)).toList();
    return BoardDataset(boardDataSet: boardDataSetlist);
  }

  final List<BoardNameDataset> boardDataSet;
}

class BoardNameDataset {
  BoardNameDataset({required this.boardName, required this.boardImageSrc});

  factory BoardNameDataset.fromJson(Map<String, dynamic> data) {
    return BoardNameDataset(
      boardName: data['board_name'],
      boardImageSrc: data['board_image_src'],
    );
  }

  final String boardImageSrc;
  final String boardName;
}

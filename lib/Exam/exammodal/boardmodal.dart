class ResultDataset {
  ResultDataset({required this.boardDataSet});

  factory ResultDataset.fromJson(Map<String, dynamic> data) {
    var list = data['board_dataset'] as List;
    List<ResultNameDataset> boardDataSetlist =
        list.map((e) => ResultNameDataset.fromJson(e)).toList();
    return ResultDataset(boardDataSet: boardDataSetlist);
  }

  final List<ResultNameDataset> boardDataSet;
}

class ResultNameDataset {
  ResultNameDataset({required this.boardName, required this.boardImageSrc});

  factory ResultNameDataset.fromJson(Map<String, dynamic> data) {
    return ResultNameDataset(
      boardName: data['board_name'],
      boardImageSrc: data['board_image_src'],
    );
  }

  final String boardImageSrc;
  final String boardName;
}

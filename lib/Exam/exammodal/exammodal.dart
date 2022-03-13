class BoardSet {
  BoardSet({required this.examDataSet});

  factory BoardSet.fromJson(Map<String, dynamic> data) {
    var list = data['exam_dataset'] as List;
    List<ExamDataSet> examDataSetlist =
        list.map((e) => ExamDataSet.fromJson(e)).toList();
    return BoardSet(examDataSet: examDataSetlist);
  }

  final List<ExamDataSet> examDataSet;
}

class ExamDataSet {
  ExamDataSet(
      {required this.Papertype,
      required this.typeimagesrc,
      required this.boardDataSet});

  factory ExamDataSet.fromJson(Map<String, dynamic> data) {
    var list = data['board_dataset'] as List;
    List<BoardDataSet> boardDataSetlist =
        list.map((e) => BoardDataSet.fromJson(e)).toList();
    return ExamDataSet(
        Papertype: data['Paper_type'],
        typeimagesrc: data['type_image_src'],
        boardDataSet: boardDataSetlist);
  }

  final String typeimagesrc;
  final String Papertype;
  final List<BoardDataSet> boardDataSet;
}

class BoardDataSet {
  BoardDataSet({
    required this.boardName,
    required this.boardimagesrc,
    required this.subjectDataset,
  });

  factory BoardDataSet.fromJson(Map<String, dynamic> data) {
    var list = data['subject_dataset'] as List;
    List<SubjectDataset> subjectDatasetlist =
        list.map((e) => SubjectDataset.fromJson(e)).toList();

    return BoardDataSet(
      boardName: data['board_name'],
      boardimagesrc: data['board_image_src'],
      subjectDataset: subjectDatasetlist,
    );
  }

  final List<SubjectDataset> subjectDataset;
  final String boardName;
  final String boardimagesrc;
}

class SubjectDataset {
  SubjectDataset(
      {required this.subjectname,
      required this.subjectimagesrc,
      required this.paperDataset});

  factory SubjectDataset.fromJson(Map<String, dynamic> data) {
    var list = data['paper_dataset'] as List;
    List<PaperDataSet> paperDatasetlist =
        list.map((e) => PaperDataSet.fromJson(e)).toList();

    return SubjectDataset(
      subjectname: data['subject_name'],
      subjectimagesrc: data['subject_image_src'],
      paperDataset: paperDatasetlist,
    );
  }

  final String subjectimagesrc;
  final String subjectname;

  final List<PaperDataSet> paperDataset;
}

class PaperDataSet {
  PaperDataSet({required this.papername,required this.id});

  factory PaperDataSet.fromJson(Map<String, dynamic> data) {
    return PaperDataSet(papername: data['paper_name'],
    id:data['id'],
    );
  }

  final String papername;
  final String id;
}

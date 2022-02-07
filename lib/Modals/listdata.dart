class DataSet {
  final List<BookDataSet> bookDataSet;

  DataSet({required this.bookDataSet});

  factory DataSet.fromJson(Map<String, dynamic> data) {
    var list = data['book_dataset'] as List;
    List<BookDataSet> bookDataSetlist =
        list.map((e) => BookDataSet.fromJson(e)).toList();
    return DataSet(bookDataSet: bookDataSetlist);
  }
}

class BookDataSet {
  final String bookName;
  final String bookImageSrc;
  final List<SubjectDataSet> subjectDataSet;

  BookDataSet(
      {required this.bookName,
      required this.bookImageSrc,
      required this.subjectDataSet});

  factory BookDataSet.fromJson(Map<String, dynamic> data) {
    var list = data['subject_dataset'] as List;
    List<SubjectDataSet> subjectDataSetlist =
        list.map((e) => SubjectDataSet.fromJson(e)).toList();
    return BookDataSet(
        bookName: data['book_name'],
        bookImageSrc: data['book_image_src'],
        subjectDataSet: subjectDataSetlist);
  }
}

class SubjectDataSet {
  final String subjectName;
  final String subjectimagesrc;
  final List<BookSolutionDataSet> bookSolutionDataSet;

  SubjectDataSet({
    required this.subjectName,
    required this.subjectimagesrc,
    required this.bookSolutionDataSet,
  });

  factory SubjectDataSet.fromJson(Map<String, dynamic> data) {
    var list = data['book_solution_dataset'] as List;
    List<BookSolutionDataSet> bookSolutionDataSetlist =
        list.map((e) => BookSolutionDataSet.fromJson(e)).toList();

    return SubjectDataSet(
      subjectName: data['subject_name'],
      subjectimagesrc: data['subject_image_src'],
      bookSolutionDataSet: bookSolutionDataSetlist,
    );
  }
}

class BookSolutionDataSet {
  final String booksolutionname;
  final String booksolutionimagesrc;
  final bool isitbook;
  final List<TopicDataSet> topicDataset;

  BookSolutionDataSet(
      {required this.booksolutionname,
      required this.booksolutionimagesrc,
      required this.isitbook,
      required this.topicDataset});

  factory BookSolutionDataSet.fromJson(Map<String, dynamic> data) {
    var list = data['topic_dataset'] as List;
    List<TopicDataSet> topicDatasetlist =
        list.map((e) => TopicDataSet.fromJson(e)).toList();

    return BookSolutionDataSet(
      booksolutionname: data['book_solution_name'],
      booksolutionimagesrc: data['book_solution_image_src'],
      isitbook: data['isitbook'],
      topicDataset: topicDatasetlist,
    );
  }
}

class TopicDataSet {
  final String topicName;

  TopicDataSet({required this.topicName});

  factory TopicDataSet.fromJson(Map<String, dynamic> data) {
    return TopicDataSet(topicName: data['topic_name']);
  }
}

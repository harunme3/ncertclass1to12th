class ClassDataSet {
  ClassDataSet({required this.classDataSet});

  factory ClassDataSet.fromJson(Map<String, dynamic> data) {
    var list = data['class_dataset'] as List;
    List<ClassNameDataSet> classDataSetlist =
        list.map((e) => ClassNameDataSet.fromJson(e)).toList();
    return ClassDataSet(classDataSet: classDataSetlist);
  }

  final List<ClassNameDataSet> classDataSet;
}

class ClassNameDataSet {
  ClassNameDataSet({required this.className, required this.classImageSrc});

  factory ClassNameDataSet.fromJson(Map<String, dynamic> data) {
    return ClassNameDataSet(
      className: data['class_name'],
      classImageSrc: data['class_image_src'],
    );
  }

  final String classImageSrc;
  final String className;
}

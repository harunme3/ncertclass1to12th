import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:ncertclass1to12th/Exam/exammodal/exammodal.dart';

class PaperProvider with ChangeNotifier {
  Future<BoardSet> loadJsonDataSet(String grade) async {
    if (grade == "Class 10") {
      String jsonstring =
          await rootBundle.loadString('assets/Paper/CBSE/class10/paper.json');
      final jsonresponse = json.decode(jsonstring);
      return BoardSet.fromJson(jsonresponse);
    } else if (grade == "Class 12") {
      String jsonstring =
          await rootBundle.loadString('assets/Paper/CBSE/class12/paper.json');
      final jsonresponse = json.decode(jsonstring);
      return BoardSet.fromJson(jsonresponse);
    } else {
      print('not match with any data_image');
      String jsonstring =
          await rootBundle.loadString('assets/Paper/CBSE/class12/paper.json');
      final jsonresponse = json.decode(jsonstring);
      return BoardSet.fromJson(jsonresponse);
    }
  }
}

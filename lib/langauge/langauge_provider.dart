import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

class LangaugeProvider with ChangeNotifier {
  LangaugeProvider(this.isHindi);

  bool isHindi;

  bool get getselectedLangauge => isHindi;

  Future<DataSet> loadJsonDataSet(String grade) async {
    if (grade == "Class 9") {
      if (isHindi) {
        String jsonstring = await rootBundle.loadString(
            'assets/alldata_image/class9/data_image/HindiModal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      } else {
        String jsonstring = await rootBundle
            .loadString('assets/alldata_image/class9/data_image/Modal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      }
    } else if (grade == "Class 10") {
      if (isHindi) {
        String jsonstring = await rootBundle.loadString(
            'assets/alldata_image/class10/data_image/HindiModal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      } else {
        String jsonstring = await rootBundle
            .loadString('assets/alldata_image/class10/data_image/Modal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      }
    } else if (grade == "Class 11") {
      if (isHindi) {
        String jsonstring = await rootBundle.loadString(
            'assets/alldata_image/class11/data_image/HindiModal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      } else {
        String jsonstring = await rootBundle
            .loadString('assets/alldata_image/class11/data_image/Modal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      }
    } else if (grade == "Class 12") {
      if (isHindi) {
        String jsonstring = await rootBundle.loadString(
            'assets/alldata_image/class12/data_image/HindiModal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      } else {
        String jsonstring = await rootBundle
            .loadString('assets/alldata_image/class12/data_image/Modal.json');
        final jsonresponse = json.decode(jsonstring);
        return DataSet.fromJson(jsonresponse);
      }
    } else {
      print('not match with any data_image');
      String jsonstring = await rootBundle
          .loadString('assets/alldata_image/class12/data_image/Modal.json');
      final jsonresponse = json.decode(jsonstring);
      return DataSet.fromJson(jsonresponse);
    }
  }

  // use to toggle the langauge
  toggleLangauge() async {
    final languagebox = await Hive.openBox('languagebox');
    languagebox.put('isHindi', !isHindi);
    isHindi = !isHindi;
    notifyListeners();
  }

  selectLangauge(value) async {
    final languagebox = await Hive.openBox('languagebox');
    languagebox.put('isHindi', value);
    isHindi = value;
    notifyListeners();
  }
}

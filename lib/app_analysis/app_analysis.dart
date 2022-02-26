import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppAnalysisProvider with ChangeNotifier {
  AppAnalysisProvider(this.appcount);

  int appcount;

  int get getcount => appcount;

  setcount(int value) async {
    final countbox = await Hive.openBox('countbox');
    countbox.put('appcount', value);
    appcount = value;
    notifyListeners();
  }
}

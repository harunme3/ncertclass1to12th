import 'package:flutter/material.dart';

class SideRoughStatus with ChangeNotifier {
  bool isSideBarOpened;
  SideRoughStatus(this.isSideBarOpened);

  bool get getisSideBarstatus => isSideBarOpened;

  set setisSideBarstatus(value) {
    isSideBarOpened = value;
    notifyListeners();
  }
}

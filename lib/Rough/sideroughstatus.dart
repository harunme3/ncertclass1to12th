import 'package:flutter/material.dart';

class SideRoughStatus with ChangeNotifier {
  SideRoughStatus(this.isSideBarOpened);

  bool isSideBarOpened;

  bool get getisSideBarstatus => isSideBarOpened;

  set setisSideBarstatus(value) {
    isSideBarOpened = value;
    notifyListeners();
  }
}

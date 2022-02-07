import 'package:ncertclass1to12th/allclass/allclass.dart';
import 'package:ncertclass1to12th/drawer_menu/drawermenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.Style1,
        mainScreen: AllClass(zoomDrawerController: _drawerController),
        menuScreen: MyDrawer(),
        borderRadius: 26.0,
        angle: 0.0,
        slideWidth: MediaQuery.of(context).size.width * .50,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeInOut,
      ),
    );
  }
}

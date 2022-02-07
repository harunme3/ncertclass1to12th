import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ThemeChanger extends StatefulWidget {
  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.dark_mode_outlined,
          ),
          SizedBox(
            width: 10,
          ),
          Text('theme_changer',
                  style: Theme.of(context).primaryTextTheme.bodyText1)
              .tr()
        ],
      ),
      onTap: () => _showThemeDialoge(context),
    );
  }

  _showThemeDialoge(BuildContext context) {
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (context) {
          bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
          return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 90),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFF000000),
                              const Color(0xFF3b3b3b),
                              const Color(0xFF777777),
                              const Color(0xFFb9b9b9),
                              const Color(0xFFFFFFFF),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Text('Theme toggle',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: FlutterSwitch(
                              showOnOff: true,
                              activeText: 'Dark',
                              inactiveText: 'Light',
                              activeTextColor: Colors.white,
                              inactiveTextColor: Colors.black,
                              width: 90.0,
                              height: 45.0,
                              toggleSize: 30.0,
                              value: Provider.of<ThemeProvider>(context)
                                      .isDarkTheme
                                  ? true
                                  : false,
                              borderRadius: 30.0,
                              padding: 1.5,
                              activeToggleColor: Color(0xFF6E40C9),
                              inactiveToggleColor: Color(0xFF2F363D),
                              activeSwitchBorder: Border.all(
                                color: Color(0xFFD1D5DA),
                                width: 4.0,
                              ),
                              inactiveSwitchBorder: Border.all(
                                color: Color(0xFFD1D5DA),
                                width: 4.0,
                              ),
                              activeColor: Colors.black,
                              inactiveColor: Colors.white,
                              activeIcon: Icon(
                                Icons.nightlight_round,
                                color: Color(0xFFF8E3A1),
                              ),
                              inactiveIcon: Icon(
                                Icons.wb_sunny,
                                color: Color(0xFFFFDF5D),
                              ),
                              onToggle: (value) {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleThemeData();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor:
                          isDarkTheme ? Colors.black : Colors.white,
                      child: SvgPicture.asset('assets/header/darkmode.svg'),
                      radius: 55,
                    ),
                  ),
                ],
              ));
        });
  }
}

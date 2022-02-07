import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageChanger extends StatefulWidget {
  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.translate,
          ),
          SizedBox(
            width: 10,
          ),
          Text('language_changer',
                  style: Theme.of(context).primaryTextTheme.bodyText1)
              .tr()
        ],
      ),
      onTap: () => _showLanguageDialoge(context),
    );
  }

  _showLanguageDialoge(BuildContext context) {
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
                              const Color(0xFF2f5fe8),
                              const Color(0xFF5b59ec),
                              const Color(0xFF7d50ed),
                              const Color(0xFF9c43ec),
                              const Color(0xFFb82fe8),
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
                            child: Text(
                              'Language toggle',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: FlutterSwitch(
                              showOnOff: true,
                              activeText: 'Eng',
                              inactiveText: 'Hindi',
                              activeTextColor: Colors.black,
                              inactiveTextColor: Colors.black,
                              width: 90.0,
                              height: 45.0,
                              toggleSize: 30.0,
                              value:
                                  Provider.of<LangaugeProvider>(context).isHindi
                                      ? true
                                      : false,
                              borderRadius: 30.0,
                              activeToggleColor: Colors.transparent,
                              inactiveToggleColor: Colors.transparent,
                              activeSwitchBorder: Border.all(
                                color: Color(0xFFD1D5DA),
                                width: 4.0,
                              ),
                              inactiveSwitchBorder: Border.all(
                                color: Color(0xFFD1D5DA),
                                width: 4.0,
                              ),
                              activeColor: Colors.white,
                              inactiveColor: Colors.white,
                              activeIcon:
                                  Image.asset('assets/header/india.png'),
                              inactiveIcon: Image.asset('assets/header/uk.png'),
                              onToggle: (value) {
                                Provider.of<LangaugeProvider>(context,
                                        listen: false)
                                    .toggleLangauge();
                                value == true
                                    ? context.setLocale(Locale('hi'))
                                    : context.setLocale(Locale('en'));
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
                      child: SvgPicture.asset('assets/header/langauge.svg'),
                      radius: 55,
                    ),
                  ),
                ],
              ));
        });
  }
}

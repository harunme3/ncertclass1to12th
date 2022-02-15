import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(this.isDarkTheme);

  bool isDarkTheme;

  // use to toggle the theme
  toggleThemeData() async {
    final settings = await Hive.openBox('themebox');
    settings.put('isDarkTheme', !isDarkTheme);
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  // Global theme data we are always check if the light theme is enabled #isDarkTheme
  ThemeData themeData() {
    return ThemeData(
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: isDarkTheme
          ? AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextStyle(color: Colors.white),
            )
          : AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              toolbarTextStyle: TextStyle(color: Colors.black),
            ),
      primaryTextTheme: isDarkTheme
          ? TextTheme(
              bodyText1:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
            )
          : TextTheme(
              bodyText1:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
      textTheme: GoogleFonts.robotoTextTheme(),
    );
  }
}

import 'package:ncertclass1to12th/drawer_menu/App_Name/app_name.dart';
import 'package:ncertclass1to12th/drawer_menu/Correction_Menu/correction_menu.dart';
import 'package:ncertclass1to12th/drawer_menu/Download_Menu/download_menu.dart';
import 'package:ncertclass1to12th/drawer_menu/Language_Changer/language_changer.dart';
import 'package:ncertclass1to12th/drawer_menu/More_Apps/more_apps.dart';
import 'package:ncertclass1to12th/drawer_menu/Notification_Menu/notification_menu.dart';
import 'package:ncertclass1to12th/drawer_menu/Rate_Us/rate_us.dart';
import 'package:ncertclass1to12th/drawer_menu/Share_App/share_app.dart';
import 'package:ncertclass1to12th/drawer_menu/Telegram/telegram.dart';
import 'package:ncertclass1to12th/drawer_menu/Theme_changer/theme_changer.dart';
import 'package:ncertclass1to12th/privacy_policy/privacypolicy.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return Container(
      color: isDarkTheme ? Colors.grey[900] : Colors.white,
      padding: EdgeInsets.only(
          top: size.height / 25,
          bottom: size.height / 25,
          left: size.height / 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppName(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height / 8, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ThemeChanger(),
                  LanguageChanger(),
                  NotificationMenu(),
                  CorrectionMenu(),
                  DownloadMenu(),
                  MoreApps(),
                  ShareApp(),
                  RateUs(),
                  TelegramJoin()
                ],
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.lock_outlined,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                    ),
                  );
                },
                child: Text('privacy_policy',
                        style: Theme.of(context).primaryTextTheme.bodyText1)
                    .tr(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ncertclass1to12th/Modals/classdata.dart';
import 'package:ncertclass1to12th/books/books.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';

import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AllClass extends StatefulWidget {
  const AllClass(this.zoomDrawerController);

  final zoomDrawerController;

  @override
  _AllClassState createState() => _AllClassState();
}

class _AllClassState extends State<AllClass> {
  Future<ClassDataSet> loadJsonClassDataSet() async {
    String jsonstring = await rootBundle
        .loadString('assets/alldata_image/all/classnamedata_image.json');
    final jsonresponse = json.decode(jsonstring);
    return ClassDataSet.fromJson(jsonresponse);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return FutureBuilder<ClassDataSet>(
      future: loadJsonClassDataSet(), // async work
      builder: (BuildContext context, AsyncSnapshot<ClassDataSet> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => widget.zoomDrawerController.toggle(),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FlutterSwitch(
                          showOnOff: true,
                          activeText: 'Eng',
                          inactiveText: 'Hindi',
                          activeTextColor: Colors.black,
                          inactiveTextColor: Colors.black,
                          width: 90.0,
                          height: 45.0,
                          toggleSize: 30.0,
                          value: Provider.of<LangaugeProvider>(context).isHindi
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
                          activeIcon: Image.asset('assets/header/india.png'),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'classes',
                        ).tr(),
                      ),
                    ],
                  ),
                  body: ListView(
                    children: [
                      Column(
                        children: [
                          GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: snapshot.data!.classDataSet.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Books(snapshot
                                              .data!
                                              .classDataSet[index]
                                              .className)));
                                },
                                child: Tooltip(
                                  textStyle: TextStyle(color: Colors.white),
                                  message: snapshot
                                      .data!.classDataSet[index].className,
                                  preferBelow: false,
                                  verticalOffset: size.width / 5,
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size.width / 24,
                                      vertical: size.width / 36,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        Container(
                                          height: size.width / 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            color: index.isEven
                                                ? AppColor.Second_color
                                                : AppColor.third_color,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: isDarkTheme
                                                  ? Colors.grey[900]
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -size.width / 60,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width / 9,
                                            ),
                                            height: size.width / 3.2,
                                            width: size.width / 2,
                                            child: Image.asset(
                                              snapshot.data!.classDataSet[index]
                                                  .classImageSrc,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: AutoSizeText(
                                            snapshot.data!.classDataSet[index]
                                                .className,
                                            maxLines: 3,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
        }
      },
    );
  }
}

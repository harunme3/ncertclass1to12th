import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncertclass1to12th/Modals/classdata.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/ncertvideosUI/videosbookui/videobook.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:provider/provider.dart';

class VideoClass extends StatefulWidget {
  const VideoClass({Key? key}) : super(key: key);

  @override
  _VideoClassState createState() => _VideoClassState();
}

class _VideoClassState extends State<VideoClass> {
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
            return SafeArea(
              child: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(),
                  body: ListView(
                    children: [
                      Column(
                        children: [
                          GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: snapshot.data!.classDataSet.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoBook(
                                              classname: snapshot
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
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ncertclass1to12th/Modals/classdata.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:ncertclass1to12th/ncertvideosUI/videossubjectui/videosubject.dart';

import 'package:provider/provider.dart';

class VideoBook extends StatefulWidget {
  const VideoBook({required this.classname});

  final String classname;

  @override
  _VideoBookState createState() => _VideoBookState();
}

class _VideoBookState extends State<VideoBook> {
  late BannerAd _ad;
  bool _isAdLoaded = false;

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createandshowBannerAd();
  }

  Future<ClassDataSet> loadJsonClassDataSet() async {
    String jsonstring = await rootBundle
        .loadString('assets/alldata_image/all/classnamedata_image.json');
    final jsonresponse = json.decode(jsonstring);
    return ClassDataSet.fromJson(jsonresponse);
  }

  _createandshowBannerAd() {
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<DataSet>(
      future: Provider.of<LangaugeProvider>(context)
          .loadJsonDataSet(widget.classname), // async work
      builder: (BuildContext context, AsyncSnapshot<DataSet> snapshot) {
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
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: snapshot.data!.bookDataSet.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoSubject(
                                              bookname: snapshot.data!
                                                  .bookDataSet[index].bookName,
                                              classname: widget.classname,
                                              subjectDataSet: snapshot
                                                  .data!
                                                  .bookDataSet[index]
                                                  .subjectDataSet)));
                                },
                                child: Tooltip(
                                  textStyle: TextStyle(color: Colors.white),
                                  message: widget.classname,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 179, 44, 3),
                                              Color.fromARGB(255, 31, 29, 102),
                                              Color.fromARGB(255, 206, 14, 126),
                                              const Color(0xFF9c43ec),
                                              Color.fromARGB(255, 219, 6, 166),
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          //image
                                          Container(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              snapshot.data!.bookDataSet[index]
                                                  .bookImageSrc,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          //name
                                          Container(
                                            child: AutoSizeText(
                                              snapshot.data!.bookDataSet[index]
                                                  .bookName,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          _isAdLoaded
                              ? Container(
                                  child: AdWidget(ad: _ad),
                                  width: _ad.size.width.toDouble(),
                                  height: _ad.size.height.toDouble(),
                                  alignment: Alignment.center,
                                )
                              : Container(),
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

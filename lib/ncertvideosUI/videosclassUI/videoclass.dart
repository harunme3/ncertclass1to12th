import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ncertclass1to12th/Modals/classdata.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';

import 'package:ncertclass1to12th/ncertvideosUI/videosbookui/videobook.dart';

class VideoClass extends StatefulWidget {
  const VideoClass({Key? key}) : super(key: key);

  @override
  _VideoClassState createState() => _VideoClassState();
}

class _VideoClassState extends State<VideoClass> {
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
      size: AdSize.banner,
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
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
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
                                            height: 64,
                                            width: 64,
                                            child: Image.asset(
                                              snapshot.data!.classDataSet[index]
                                                  .classImageSrc,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          //name
                                          Container(
                                            child: AutoSizeText(
                                              snapshot.data!.classDataSet[index]
                                                  .className,
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
                        ],
                      ),
                    ],
                  ),
                  bottomNavigationBar: _isAdLoaded
                      ? Container(
                          child: AdWidget(ad: _ad),
                          width: _ad.size.width.toDouble(),
                          height: _ad.size.height.toDouble(),
                          alignment: Alignment.center,
                        )
                      : Container(),
                ),
              );
        }
      },
    );
  }
}

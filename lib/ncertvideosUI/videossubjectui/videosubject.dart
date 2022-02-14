import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:ncertclass1to12th/ncertvideos/videosncert/allplaylist.dart';
import 'package:provider/provider.dart';

class VideoSubject extends StatefulWidget {
  const VideoSubject(
      {required this.bookname,
      required this.classname,
      required this.subjectDataSet});
  final String bookname;
  final String classname;
  final List<SubjectDataSet> subjectDataSet;
  @override
  _VideoSubjectState createState() => _VideoSubjectState();
}

//Globally define load attempt
const int maxFailedLoadAttempts = 3;

class _VideoSubjectState extends State<VideoSubject> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.bookname,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: widget.subjectDataSet.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        _showInterstitialAd();
                        final medium = await Provider.of<LangaugeProvider>(
                                    context,
                                    listen: false)
                                .isHindi
                            ? 'HindiMedium'
                            : 'EnglishMedium';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllPlaylist(
                                    bookname: widget.bookname,
                                    classname: widget.classname,
                                    medium: medium,
                                    subjectname: widget
                                        .subjectDataSet[index].subjectName,
                                  )),
                        );
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //image
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    widget
                                        .subjectDataSet[index].subjectimagesrc,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                //name
                                Container(
                                  child: AutoSizeText(
                                    widget.subjectDataSet[index].subjectName,
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
      ),
    );
  }
}

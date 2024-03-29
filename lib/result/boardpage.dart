import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ncertclass1to12th/Exam/exammodal/boardmodal.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/result/result.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:provider/provider.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key, required this.classname}) : super(key: key);

  final String classname;

  @override
  State<BoardPage> createState() => _BoardPageState();
}

//Globally define load attempt
const int maxFailedLoadAttempts = 3;

class _BoardPageState extends State<BoardPage> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  Future<ResultDataset> loadborddata() async {
    String jsonstring = await rootBundle.loadString('assets/board/board.json');
    final jsonresponse = json.decode(jsonstring);
    return ResultDataset.fromJson(jsonresponse);
  }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return FutureBuilder<ResultDataset>(
        future: loadborddata(),
        builder: (BuildContext context, AsyncSnapshot<ResultDataset> snapshot) {
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
                    body: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: snapshot.data!.boardDataSet.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _showInterstitialAd();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                          boardname: snapshot.data!
                                              .boardDataSet[index].boardName,
                                          classname: widget.classname,
                                        )));
                          },
                          child: Tooltip(
                            textStyle: TextStyle(color: Colors.white),
                            message:
                                snapshot.data!.boardDataSet[index].boardName,
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
                                  color: isDarkTheme
                                      ? Colors.grey[900]
                                      : Colors.white,
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
                                        snapshot.data!.boardDataSet[index]
                                            .boardImageSrc,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    //name
                                    Container(
                                      child: AutoSizeText(
                                        snapshot.data!.boardDataSet[index]
                                            .boardName,
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
                  ),
                );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ncertclass1to12th/SlideUp_Pdfoption/slideup_pdfoption.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class LastOpenedPdf extends StatefulWidget {
  const LastOpenedPdf({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  _LastOpenedPdfState createState() => _LastOpenedPdfState();
}

//Globally define load attempt
const int maxFailedLoadAttempts = 3;

class _LastOpenedPdfState extends State<LastOpenedPdf> {
  //pdfviewcontroller

  late PDFViewController controller;

  int indexPage = 0;
  int pages = 0;
  final PanelController panelController = PanelController();

  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;
//Alert Diologe
  TextEditingController _textFieldController = TextEditingController();

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
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        _showInterstitialAd();

        return Future<bool>.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Pdf',
                style: Theme.of(context).primaryTextTheme.bodyText1),
            actions: <Widget>[
              Center(
                child: Text(
                  '${indexPage + 1}/$pages',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.pin_outlined,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Jump to page'),
                        content: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                              hintText: "Enter Numeric value :Ex-5"),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: Text('OK'),
                            onPressed: () {
                              controller.setPage(
                                  int.parse(_textFieldController.text) - 1);
                              _textFieldController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                ),
                onPressed: () {
                  panelController.isPanelOpen
                      ? panelController.close()
                      : panelController.open();
                },
              ),
            ],
          ),
          body: SlidingUpPanel(
            controller: panelController,
            maxHeight: size.height / 2.5,
            minHeight: 0,
            parallaxEnabled: true,
            backdropEnabled: true,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            panelBuilder: (scrollController) =>
                Paneloption(scrollController, panelController),
            body: Container(
              child: PDFView(
                filePath: widget.path,
                autoSpacing: false,
                pageSnap: false,
                pageFling: false,
                onRender: (pages) => setState(() => this.pages = pages!),
                onViewCreated: (controller) =>
                    setState(() => this.controller = controller),
                onPageChanged: (indexPage, _) =>
                    setState(() => this.indexPage = indexPage!),
              ),
            ),
          )),
    );
  }
}

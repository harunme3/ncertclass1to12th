import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:logger/logger.dart';
import 'package:ncertclass1to12th/DownloadforTopic/downloadplatform.dart';
import 'package:ncertclass1to12th/Rough/siderough.dart';
import 'package:ncertclass1to12th/Rough/sideroughstatus.dart';
import 'package:ncertclass1to12th/SlideUp_Pdfoption/slideup_pdfoption.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/pdf%20view/hintpdf.dart';
import 'package:ncertclass1to12th/pdf%20view/pdfviewdarkmode.dart';
import 'package:ncertclass1to12th/pdf%20view/pdfviewdistractionfreemode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewLocation extends StatefulWidget {
  const PdfViewLocation({
    required this.file,
    this.filename,
    this.pathofdata,
    this.isitcomefromdownload,
  });

  final File file;
  final String? filename;
  final String? pathofdata;
  final bool? isitcomefromdownload;

  @override
  _PdfViewLocationState createState() => _PdfViewLocationState();
}

//Globally define load attempt
const int maxFailedLoadAttempts = 3;

class _PdfViewLocationState extends State<PdfViewLocation> {
  late PDFViewController controller;
  int indexPage = 0;
//pdfviewcontroller
  var l = Logger();

  int pages = 0;
  final PanelController panelController = PanelController();
  SideRoughStatus sideRoughStatus = SideRoughStatus(false);

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
    setpdfpath();

    _createInterstitialAd();
  }

  setpdfpath() async {
    final pdfbox = await Hive.openBox('pdfbox');
    pdfbox.clear();
    pdfbox.put('lastopenpdf', widget.file.path);
    pdfbox.close();
  }

  Future ishintdownloaded(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    if (file.existsSync()) {
      return file;
    } else {
      return false;
    }
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
        if (widget.isitcomefromdownload != null) {
          _showInterstitialAd();
        }
        return Future<bool>.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Pdf', style: Theme.of(context).primaryTextTheme.bodyText1),
          actions: <Widget>[
            Center(
              child: Text(
                '${indexPage + 1}/$pages',
                style: TextStyle(fontSize: 18),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.dark_mode_outlined,
              ),
              onPressed: () {
                InAppUpdate.checkForUpdate().then((info) {
                  if (info.flexibleUpdateAllowed) {
                    InAppUpdate.startFlexibleUpdate().then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Your app is now Upto date'),
                        ),
                      );
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Update it later'),
                        ),
                      );
                    });
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfDarkMode(widget.file)),
                  );
                }).catchError((e) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfDarkMode(widget.file)),
                  );
                });
              },
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
                Icons.crop_free_outlined,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PdfViewDistractionFreeMode(widget.file)),
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
        body: Stack(
          children: [
            SlidingUpPanel(
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
                  filePath: widget.file.path,
                  autoSpacing: false,
                  pageSnap: false,
                  pageFling: false,
                  onRender: (pages) => setState(() {
                    this.pages = pages!;
                  }),
                  onViewCreated: (controller) => setState(() {
                    this.controller = controller;
                  }),
                  onPageChanged: (indexPage, _) => setState(() {
                    this.indexPage = indexPage!;
                  }),
                ),
              ),
            ),
            SideRough()
          ],
        ),
        floatingActionButton: widget.pathofdata != null &&
                !Provider.of<SideRoughStatus>(context, listen: false)
                    .getisSideBarstatus
            ? FloatingActionButton(
                backgroundColor: AppColor.third_color,
                foregroundColor: AppColor.white_color,
                splashColor: AppColor.first_color,
                child: Text('Hint'),
                onPressed: () async {
                  _showInterstitialAd();
                  var file = await ishintdownloaded(widget.filename! + '.pdf');

                  if (file != false) {
                    l.e('File is already downloaded');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HintPdf(file: file)),
                    );
                  } else if (file == false) {
                    l.e('we have to download the file');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DownloadPlatform(
                              filename: widget.filename!,
                              pathofdata: widget.pathofdata!)),
                    );
                  }
                },
              )
            : null,
      ),
    );
  }
}

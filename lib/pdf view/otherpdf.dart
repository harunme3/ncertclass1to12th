import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:ncertclass1to12th/SlideUp_Pdfoption/slideup_pdfoption.dart';
import 'package:ncertclass1to12th/pdf%20view/pdfviewdarkmode.dart';
import 'package:ncertclass1to12th/pdf%20view/pdfviewdistractionfreemode.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class OtherPdf extends StatefulWidget {
  const OtherPdf({
    required this.file,
  });

  final File file;

  @override
  _OtherPdfState createState() => _OtherPdfState();
}

class _OtherPdfState extends State<OtherPdf> {
//pdfviewcontroller

  late PDFViewController controller;

  int indexPage = 0;
  int pages = 0;
  final PanelController panelController = PanelController();
  final ScreenshotController screenshotController = ScreenshotController();

//Alert Diologe
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setpdfpath();
  }

  setpdfpath() async {
    final pdfbox = await Hive.openBox('pdfbox');
    pdfbox.clear();
    pdfbox.put('lastopenpdf', widget.file.path);
    pdfbox.close();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pdf', style: Theme.of(context).primaryTextTheme.bodyText1),
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
      body: SlidingUpPanel(
        controller: panelController,
        maxHeight: size.height / 2.5,
        minHeight: 0,
        parallaxEnabled: true,
        backdropEnabled: true,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        panelBuilder: (scrollController) => Paneloption(
            scrollController, screenshotController, panelController),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            child: UCPDFView(
              filePath: widget.file.path,
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
        ),
      ),
    );
  }
}
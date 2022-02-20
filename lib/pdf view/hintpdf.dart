import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/SlideUp_Pdfoption/slideup_pdfoption.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class HintPdf extends StatefulWidget {
  const HintPdf({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  _HintPdfState createState() => _HintPdfState();
}

class _HintPdfState extends State<HintPdf> {
  //pdfviewcontroller

  late PDFViewController controller;

  int indexPage = 0;
  int pages = 0;
  final PanelController panelController = PanelController();
  final ScreenshotController screenshotController = ScreenshotController();

//Alert Diologe
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class PdfViewDistractionFreeMode extends StatefulWidget {
  PdfViewDistractionFreeMode(this.file);

  final File file;

  @override
  _PdfViewDistractionFreeModeState createState() =>
      _PdfViewDistractionFreeModeState();
}

class _PdfViewDistractionFreeModeState
    extends State<PdfViewDistractionFreeMode> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: UCPDFView(
          filePath: widget.file.path,
          autoSpacing: false,
          pageSnap: false,
          pageFling: false,
        )),
      ),
    );
  }
}

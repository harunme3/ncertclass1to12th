import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class PdfDarkMode extends StatelessWidget {
  final File file;

  const PdfDarkMode(this.file);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: UCPDFView(
          filePath: file.path,
          autoSpacing: false,
          pageSnap: false,
          pageFling: false,
          nightMode: true,
        )),
      ),
    );
  }
}

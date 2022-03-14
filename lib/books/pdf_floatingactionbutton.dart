import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/pdf%20view/lastopnedpdf.dart';

class LastopenPDFButton extends StatefulWidget {
  const LastopenPDFButton({
    Key? key,
  }) : super(key: key);

  @override
  State<LastopenPDFButton> createState() => _LastopenPDFButtonState();
}

//Globally define load attempt
const int maxFailedLoadAttempts = 3;

class _LastopenPDFButtonState extends State<LastopenPDFButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Last Opened Pdf',
      backgroundColor: AppColor.third_color,
      foregroundColor: AppColor.white_color,
      splashColor: AppColor.first_color,
      child: Icon(
        Icons.chrome_reader_mode_outlined,
      ),
      onPressed: () async {
        final pdfbox = await Hive.openBox('pdfbox');
        var path = pdfbox.get('lastopenpdf');

        if (path != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LastOpenedPdf(path: path)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You have not open any pdf yet'),
            ),
          );
        }
      },
    );
  }
}

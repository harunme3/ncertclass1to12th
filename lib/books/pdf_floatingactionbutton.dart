import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/pdf%20view/lastopnedpdf.dart';

class LastopenPDFButton extends StatelessWidget {
  const LastopenPDFButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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

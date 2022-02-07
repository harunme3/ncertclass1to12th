import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ncertclass1to12th/pdf%20view/lastopnedpdf.dart';

class LastopenPDFButton extends StatelessWidget {
  const LastopenPDFButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Container(
        height: size.width / 6,
        width: size.width / 6,
        child: Icon(
          Icons.chrome_reader_mode_outlined,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [
            const Color(0xFF2f5fe8),
            const Color(0xFF5b59ec),
            const Color(0xFF7d50ed),
            const Color(0xFF9c43ec),
            const Color(0xFFb82fe8),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
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

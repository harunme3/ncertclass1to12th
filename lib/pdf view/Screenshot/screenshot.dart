import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'dart:io';

class PdfScreenShot {
  static void saveandshare(Uint8List? bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes!);
    await Share.shareFiles(
      [image.path],
      text:
          'For NCERT Solution install this App from Play store https://play.google.com/store/apps/details?id=com.vs.ncertclass10thhindi',
    );
  }
}

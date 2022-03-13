import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class OnlinePdfViwer extends StatefulWidget {
  const OnlinePdfViwer({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<OnlinePdfViwer> createState() => _OnlinePdfViwerState();
}

class _OnlinePdfViwerState extends State<OnlinePdfViwer> {
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    print(widget.url);
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = widget.url;

      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
        future: createFileOfPdfUrl(),
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SafeArea(
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            default:
              if (snapshot.hasError)
                return Scaffold(
                    body: Center(
                        child: AutoSizeText(
                  'No data inform us on rahulguptasonu123@gmail.com',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                  maxLines: 2,
                )));
              else
                return SafeArea(
                  child: Scaffold(
                    appBar: AppBar(),
                    body: Container(
                        child: UCPDFView(filePath: snapshot.data!.path)),
                  ),
                );
          }
        });
  }
}

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:ncertclass1to12th/pdf%20view/otherpdf.dart';
import 'package:ncertclass1to12th/pdf%20view/pdf%20view_location.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DownloadPlatform extends StatefulWidget {
  const DownloadPlatform({required this.pathofdata, required this.filename});

  final String pathofdata;
  final String filename;

  @override
  _DownloadPlatformState createState() => _DownloadPlatformState();
}

class _DownloadPlatformState extends State<DownloadPlatform> {
  var l = Logger();
  File? file;
  DownloadTask? task;
  double _percenatge = 0;

  @override
  void dispose() {
    if (task != null) {
      task!.cancel().then((value) => {
            print(
                '================================task cancel ==================================')
          });
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    downloadpdfdata(widget.pathofdata, widget.filename);
  }

  deletePdfdata(File file) {
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  void downloadpdfdata(pathofdata, filename) async {
    final ref = await FirebaseStorage.instance.ref(pathofdata).listAll();

    if (ref.items.isNotEmpty) {
      ref.items.forEach((e) {
        filename = filename + '.pdf';
        writefile(e, filename);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('can_not_download').tr(),
        ),
      );
    }
  }

  writefile(Reference ref, String filename) async {
    final dir = await getApplicationDocumentsDirectory();

    this.file = File('${dir.path}/$filename');

    this.task = ref.writeToFile(file!);

    task!.snapshotEvents.listen((snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      setState(() {
        _percenatge = ((snapshot.bytesTransferred / snapshot.totalBytes) * 100);
      });
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task!.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    task!.whenComplete(() => {
          _percenatge = 0,
          print(
              '================================task completed=================================='),
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OtherPdf(file: file!)),
          ),
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200.0),
            child: AppBar(
              flexibleSpace: Container(
                child: SvgPicture.asset('assets/header/Downloadplatform.svg'),
              ),
              elevation: 0.0,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  child: LiquidLinearProgressIndicator(
                    borderRadius: 20.0,
                    value: _percenatge / 100,
                    center: Text('${_percenatge.abs().toStringAsFixed(0)}%',
                        style: Theme.of(context).primaryTextTheme.bodyText1),
                    direction: Axis.horizontal,
                    backgroundColor:
                        isDarkTheme ? Colors.grey[900] : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (_percenatge == 100) {
          print(
              '================================task completed 100%==================================');
          Navigator.of(context).pop(false);
        } else {
          if (task != null) {
            task!.cancel().then((value) => {
                  print(
                      '================================task cancel ==================================')
                });
          }
          if (file != null) {
            deletePdfdata(file!);
            print(
                '================================file deleted ==================================');
          }
          _percenatge = 0;
          Navigator.of(context).pop(false);
        }
        return false;
      },
    );
  }
}

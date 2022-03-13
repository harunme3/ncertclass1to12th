import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/DownloadforTopic/downloadplatform.dart';
import 'package:ncertclass1to12th/Exam/exammodal/exammodal.dart';
import 'package:ncertclass1to12th/pdf%20view/pdf%20view_location.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AllPaperList extends StatefulWidget {
  const AllPaperList(
      {Key? key,
      required this.subjectDataset,
      required this.boardName,
      required this.classname,
      required this.papertype,
      required this.subjectname})
      : super(key: key);

  final String boardName;
  final String classname;
  final String papertype;
  final SubjectDataset subjectDataset;
  final String subjectname;

  @override
  State<AllPaperList> createState() => _AllPaperListState();
}

class _AllPaperListState extends State<AllPaperList> {
  Future canviewpdf(int index) async {
    final classname = widget.classname.split(' ').last;
    final papertype = widget.papertype.split(' ').first;
    final boardName = widget.boardName.split(' ').first;
    final subjectname = widget.subjectname.split(' ').first +
        widget.subjectname.split(' ').last;

    final papername =
        widget.subjectDataset.paperDataset[index].papername.split('-').last +
            index.toString();

    String filename =
        '${classname}_${papertype}_${boardName}_${subjectname}_${papername}' +
            '.pdf';
    ;

    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (file.existsSync()) {
      return file;
    } else {
      return false;
    }
  }

  deletePdfdata(index, File file) {
    if (file.existsSync()) {
      file.deleteSync();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return FutureBuilder(
                  future: canviewpdf(index),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('');
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return snapshot.data != false
                              ? GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewLocation(
                                              file: snapshot.data)),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFF2f5fe8),
                                              const Color(0xFF5b59ec),
                                              const Color(0xFF7d50ed),
                                              const Color(0xFF9c43ec),
                                              const Color(0xFFb82fe8),
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: CircleAvatar(
                                            backgroundColor: isDarkTheme
                                                ? Colors.black
                                                : Colors.white,
                                            child: Text(index.toString(),
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1),
                                          )),
                                          Flexible(
                                            child: AutoSizeText(
                                                widget
                                                    .subjectDataset
                                                    .paperDataset[index]
                                                    .papername,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              deletePdfdata(
                                                  index, snapshot.data);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons
                                                  .delete_outline_outlined),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    final projectname = 'Exam';
                                    final classname =
                                        widget.classname.split(' ').last;
                                    final papertype =
                                        widget.papertype.split(' ').first;
                                    final boardName =
                                        widget.boardName.split(' ').first;
                                    final subjectname =
                                        widget.subjectname.split(' ').first +
                                            widget.subjectname.split(' ').last;

                                    final papername = widget.subjectDataset
                                            .paperDataset[index].papername
                                            .split('-')
                                            .last +
                                        index.toString();
                                    final String pathofdata =
                                        '$projectname/$classname/$papertype/$boardName/$subjectname/$papername/';

                                    String filename =
                                        '${classname}_${papertype}_${boardName}_${subjectname}_${papername}';

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DownloadPlatform(
                                                pathofdata: pathofdata,
                                                filename: filename,
                                              )),
                                    ).then((value) {
                                      setState(() {
                                        print(
                                            '================================Reload==================================');
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFF2f5fe8),
                                              const Color(0xFF5b59ec),
                                              const Color(0xFF7d50ed),
                                              const Color(0xFF9c43ec),
                                              const Color(0xFFb82fe8),
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: CircleAvatar(
                                            backgroundColor: isDarkTheme
                                                ? Colors.black
                                                : Colors.white,
                                            child: Text(index.toString(),
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1),
                                          )),
                                          Flexible(
                                            child: AutoSizeText(
                                                widget
                                                    .subjectDataset
                                                    .paperDataset[index]
                                                    .papername,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons
                                                .download_for_offline_outlined),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                    }
                  },
                );
              }, childCount: widget.subjectDataset.paperDataset.length))
            ],
          )),
    );
  }
}

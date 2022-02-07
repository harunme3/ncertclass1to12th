import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/DownloadforTopic/downloadplatform.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:ncertclass1to12th/pdf%20view/pdf%20view_location.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TopicList extends StatefulWidget {
  TopicList(this.topicDataSet, this.index1, this.index2, this.index3,
      this.booksolutionname, this.classname);

  final String booksolutionname;
  final index1;
  final index2;
  final index3;
  final List<TopicDataSet> topicDataSet;
  final String classname;

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  deletePdfdata(index, File file) {
    if (file.existsSync()) {
      file.deleteSync();
      setState(() {});
    }
  }

  Future canviewpdf(int index, DataSet dataSet) async {
    String language = 'en';

    final bookname = dataSet.bookDataSet[widget.index1].bookName;
    final subjectname = dataSet
        .bookDataSet[widget.index1].subjectDataSet[widget.index2].subjectName;
    final booksolutionname = dataSet
        .bookDataSet[widget.index1]
        .subjectDataSet[widget.index2]
        .bookSolutionDataSet[widget.index3]
        .booksolutionname;
    final topicname = dataSet
        .bookDataSet[widget.index1]
        .subjectDataSet[widget.index2]
        .bookSolutionDataSet[widget.index3]
        .topicDataset[index]
        .topicName;

    String filename =
        '${bookname}_${subjectname}_${booksolutionname}_${topicname}_$language' +
            '.pdf';

    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (file.existsSync()) {
      return file;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return FutureBuilder<DataSet>(
        future: Provider.of<LangaugeProvider>(context)
            .loadJsonDataSet(widget.classname),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                //Background page on reload
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              );
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return SafeArea(
                  child: Scaffold(
                    body: CustomScrollView(
                      physics: ClampingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 180,
                          flexibleSpace: FlexibleSpaceBar(
                            background: SvgPicture.asset(
                                'assets/header/topicwithoutsubtopic.svg'),
                            collapseMode: CollapseMode.pin,
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          titleSpacing: 0,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              widget.booksolutionname,
                              maxLines: 2,
                              textAlign: TextAlign.right,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          stretch: true,
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                          return FutureBuilder(
                            future: canviewpdf(index, snapshot.data),
                            builder: (BuildContext context,
                                AsyncSnapshot viewpdfsnapshot) {
                              switch (viewpdfsnapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Text('');
                                default:
                                  if (snapshot.hasError)
                                    return Text('Error: ${snapshot.error}');
                                  else
                                    return viewpdfsnapshot.data != false
                                        ? GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfViewLocation(
                                                            viewpdfsnapshot
                                                                .data)),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16.0),
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
                                                      end:
                                                          Alignment.bottomLeft),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        child: CircleAvatar(
                                                      backgroundColor:
                                                          isDarkTheme
                                                              ? Colors.black
                                                              : Colors.white,
                                                      child: Text(
                                                          index.toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1),
                                                    )),
                                                    Flexible(
                                                      child: AutoSizeText(
                                                          widget
                                                              .topicDataSet[
                                                                  index]
                                                              .topicName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        deletePdfdata(
                                                            index,
                                                            viewpdfsnapshot
                                                                .data);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DownloadPlatform(
                                                            index,
                                                            snapshot.data,
                                                            widget.index1,
                                                            widget.index2,
                                                            widget.index3,
                                                            'en')),
                                              ).then((value) {
                                                setState(() {
                                                  print(
                                                      '================================Reload==================================');
                                                });
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16.0),
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
                                                      end:
                                                          Alignment.bottomLeft),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        child: CircleAvatar(
                                                      backgroundColor:
                                                          isDarkTheme
                                                              ? Colors.black
                                                              : Colors.white,
                                                      child: Text(
                                                          index.toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1),
                                                    )),
                                                    Flexible(
                                                      child: AutoSizeText(
                                                          widget
                                                              .topicDataSet[
                                                                  index]
                                                              .topicName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                        }, childCount: widget.topicDataSet.length))
                      ],
                    ),
                  ),
                );
          }
        });
  }
}

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
import 'package:logger/logger.dart';

class TopicList extends StatefulWidget {
  TopicList({
    this.bookSolutionDataSet,
    required this.bookname,
    required this.booksolutionname,
    required this.classname,
    this.solutionindex,
    required this.subjectname,
    required this.topicDataSet,
  });

  final List<BookSolutionDataSet>? bookSolutionDataSet;
  final String bookname;
  final String booksolutionname;
  final String classname;
  final int? solutionindex;
  final String subjectname;
  final List<TopicDataSet> topicDataSet;

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  var l = Logger();

  deletePdfdata(index, File file) {
    if (file.existsSync()) {
      file.deleteSync();
      setState(() {});
    }
  }

  Future canviewpdf(int index) async {
    final projectname = 'Education';
    final examname = 'NCERT and Exampler';
    final classname = widget.classname;
    final medium =
        await Provider.of<LangaugeProvider>(context, listen: false).isHindi
            ? 'HindiMedium'
            : 'EnglishMedium';

    final bookname = widget.bookname;
    final subjectname = widget.subjectname;
    final booksolutionname = widget.booksolutionname;
    final topicname = widget.topicDataSet[index].topicName;

    String filename =
        '${projectname}_${examname}_${classname}_${medium}_${bookname}_${subjectname}_${booksolutionname}_$topicname' +
            '.pdf';

    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (file.existsSync()) {
      return file;
    } else {
      return false;
    }
  }

  Future<int> isSolutionExist(int index) async {
    int count = 0;

    for (var i
        in widget.bookSolutionDataSet![widget.solutionindex!].topicDataset) {
      count++;
      if (i.topicName == widget.topicDataSet[index].topicName) {
        return count;
      }
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              background: SvgPicture.asset('assets/header/TopicList.svg'),
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
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
            stretch: true,
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
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
                                if (widget.solutionindex != null) {
                                  int status = await isSolutionExist(index);

                                  if (status != 0) {
                                    l.e(status - 1);
                                    final projectname = 'Education';
                                    final examname = 'NCERT and Exampler';
                                    final classname = widget.classname;
                                    final medium =
                                        await Provider.of<LangaugeProvider>(
                                                    context,
                                                    listen: false)
                                                .isHindi
                                            ? 'HindiMedium'
                                            : 'EnglishMedium';

                                    final bookname = widget.bookname;
                                    final subjectname = widget.subjectname;
                                    final booksolutionname = widget
                                        .bookSolutionDataSet![
                                            widget.solutionindex!]
                                        .booksolutionname;
                                    final topicname = widget
                                        .bookSolutionDataSet![
                                            widget.solutionindex!]
                                        .topicDataset[status - 1]
                                        .topicName;
                                    final String pathofdata =
                                        '$projectname/$examname/$classname/$medium/$bookname/$subjectname/$booksolutionname/$topicname/';
                                    String filename =
                                        '${projectname}_${examname}_${classname}_${medium}_${bookname}_${subjectname}_${booksolutionname}_$topicname';
                                    l.e(topicname);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewLocation(
                                              file: snapshot.data,
                                              filename: filename,
                                              pathofdata: pathofdata)),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewLocation(
                                              file: snapshot.data)),
                                    );
                                  }
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PdfViewLocation(
                                            file: snapshot.data)),
                                  );
                                }
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
                                                .topicDataSet[index].topicName,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          deletePdfdata(index, snapshot.data);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                              Icons.delete_outline_outlined),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final projectname = 'Education';
                                final examname = 'NCERT and Exampler';
                                final classname = widget.classname;
                                final medium =
                                    await Provider.of<LangaugeProvider>(context,
                                                listen: false)
                                            .isHindi
                                        ? 'HindiMedium'
                                        : 'EnglishMedium';

                                final bookname = widget.bookname;
                                final subjectname = widget.subjectname;
                                final booksolutionname =
                                    widget.booksolutionname;
                                final topicname =
                                    widget.topicDataSet[index].topicName;

                                final String pathofdata =
                                    '$projectname/$examname/$classname/$medium/$bookname/$subjectname/$booksolutionname/$topicname/';
                                final String filename =
                                    '${projectname}_${examname}_${classname}_${medium}_${bookname}_${subjectname}_${booksolutionname}_${topicname}';

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DownloadPlatform(
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
                                                .topicDataSet[index].topicName,
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
          }, childCount: widget.topicDataSet.length))
        ],
      )),
    );
  }
}

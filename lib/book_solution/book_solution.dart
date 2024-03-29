import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/topiclist/topiclist.dart';
import 'package:provider/provider.dart';

class MyBookandSolution extends StatefulWidget {
  const MyBookandSolution({
    required this.bookSolutionDataSet,
    required this.bookname,
    required this.classname,
    required this.subjectname,
  });

  final List<BookSolutionDataSet> bookSolutionDataSet;
  final String bookname;
  final String classname;
  final String subjectname;

  @override
  _MyBookandSolutionState createState() => _MyBookandSolutionState();
}

class _MyBookandSolutionState extends State<MyBookandSolution> {
  var l = Logger();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background:
                  SvgPicture.asset('assets/header/booksandsolution.svg'),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.classname,
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.bookSolutionDataSet.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.bookSolutionDataSet[index].isitbook &&
                            index + 1 < widget.bookSolutionDataSet.length &&
                            !widget.bookSolutionDataSet[index + 1].isitbook) {
                          l.e('This Subject Books has Solutions Books');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicList(
                                      bookSolutionDataSet:
                                          widget.bookSolutionDataSet,
                                      bookname: widget.bookname,
                                      booksolutionname: widget
                                          .bookSolutionDataSet[index]
                                          .booksolutionname,
                                      classname: widget.classname,
                                      solutionindex: index + 1,
                                      subjectname: widget.subjectname,
                                      topicDataSet: widget
                                          .bookSolutionDataSet[index]
                                          .topicDataset,
                                    )),
                          );
                        } else {
                          l.e('This Subject Books has not Solutions Books');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicList(
                                      bookname: widget.bookname,
                                      booksolutionname: widget
                                          .bookSolutionDataSet[index]
                                          .booksolutionname,
                                      classname: widget.classname,
                                      subjectname: widget.subjectname,
                                      topicDataSet: widget
                                          .bookSolutionDataSet[index]
                                          .topicDataset,
                                    )),
                          );
                        }
                      },
                      child: Tooltip(
                        textStyle: TextStyle(color: Colors.white),
                        message:
                            widget.bookSolutionDataSet[index].booksolutionname,
                        preferBelow: false,
                        verticalOffset: size.width / 5,
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
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width / 24,
                            vertical: size.width / 36,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              Container(
                                height: size.width / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: index.isEven
                                      ? AppColor.Second_color
                                      : AppColor.third_color,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: isDarkTheme
                                        ? Colors.grey[900]
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -size.width / 60,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 9,
                                  ),
                                  height: size.width / 3.2,
                                  width: size.width / 2,
                                  child: Image.asset(
                                    widget.bookSolutionDataSet[index]
                                        .booksolutionimagesrc,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    widget.bookSolutionDataSet[index]
                                        .booksolutionname,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

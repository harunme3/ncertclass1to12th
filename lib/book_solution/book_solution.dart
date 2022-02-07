import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/topiclist/topiclist.dart';
import 'package:provider/provider.dart';

class MyBookandSolution extends StatefulWidget {
  final index1;
  final index2;
  final List<BookSolutionDataSet> bookSolutionDataSet;
  final String subjectname;
  final String classname;
  const MyBookandSolution(this.bookSolutionDataSet, this.index1, this.index2,
      this.subjectname, this.classname);

  @override
  _MyBookandSolutionState createState() => _MyBookandSolutionState();
}

class _MyBookandSolutionState extends State<MyBookandSolution> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background:
                    SvgPicture.asset('assets/header/booksandsolution.svg'),
              ),

              expandedHeight: 180,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: () => Navigator.pop(context),
              ),
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  widget.subjectname,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
              stretch: true, //IconButton
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TopicList(
                                widget.bookSolutionDataSet[index].topicDataset,
                                widget.index1,
                                widget.index2,
                                index,
                                widget.bookSolutionDataSet[index]
                                    .booksolutionname,
                                widget.classname)),
                      );
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
                          ],
                        ),
                      ),
                    ),
                  );
                }, childCount: widget.bookSolutionDataSet.length),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                )),
          ],
        ),
      ),
    );
  }
}

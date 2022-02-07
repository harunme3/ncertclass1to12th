import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:ncertclass1to12th/subject/subjects.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:provider/provider.dart';

class Books extends StatefulWidget {
  const Books({required this.classname});

  final String classname;

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;

    return FutureBuilder<DataSet>(
      future: Provider.of<LangaugeProvider>(context)
          .loadJsonDataSet(widget.classname), // async work
      builder: (BuildContext context, AsyncSnapshot<DataSet> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SafeArea(
              child: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return SafeArea(
                child: Scaffold(
                  body: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background:
                              SvgPicture.asset('assets/header/books.svg'),
                        ),

                        expandedHeight: 180,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_outlined),
                          onPressed: () => Navigator.pop(context),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.classname,
                            ),
                          ),
                        ], //IconButton
                      ),
                      SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Subject(
                                              bookname: snapshot.data!
                                                  .bookDataSet[index].bookName,
                                              classname: widget.classname,
                                              subjectDataSet: snapshot
                                                  .data!
                                                  .bookDataSet[index]
                                                  .subjectDataSet,
                                            )),
                                  );
                                },
                                child: Tooltip(
                                  textStyle: TextStyle(color: Colors.white),
                                  message: widget.classname,
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
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            color: index.isEven
                                                ? AppColor.Second_color
                                                : AppColor.third_color,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
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
                                              snapshot.data!.bookDataSet[index]
                                                  .bookImageSrc,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AutoSizeText(
                                              snapshot.data!.bookDataSet[index]
                                                  .bookName,
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
                            childCount: snapshot.data!.bookDataSet.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          )),
                    ],
                  ),
                ),
              );
        }
      },
    );
  }
}

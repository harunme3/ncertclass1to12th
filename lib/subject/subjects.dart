import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/book_solution/book_solution.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Subject extends StatefulWidget {
  const Subject(
      {required this.bookname,
      required this.classname,
      required this.subjectDataSet});

  final String bookname;
  final String classname;
  final List<SubjectDataSet> subjectDataSet;

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  late BannerAd _ad;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    _createandshowBannerAd();
  }

  _createandshowBannerAd() {
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

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
              background: SvgPicture.asset('assets/header/subjectheader.svg'),
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
                  itemCount: widget.subjectDataSet.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBookandSolution(
                              bookSolutionDataSet: widget
                                  .subjectDataSet[index].bookSolutionDataSet,
                              bookname: widget.bookname,
                              classname: widget.classname,
                              subjectname:
                                  widget.subjectDataSet[index].subjectName,
                            ),
                          ),
                        );
                      },
                      child: Tooltip(
                        textStyle: TextStyle(color: Colors.white),
                        message: widget.subjectDataSet[index].subjectName,
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
                                    widget
                                        .subjectDataSet[index].subjectimagesrc,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AutoSizeText(
                                    widget.subjectDataSet[index].subjectName,
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
        bottomNavigationBar: _isAdLoaded
            ? Container(
                child: AdWidget(ad: _ad),
                width: _ad.size.width.toDouble(),
                height: _ad.size.height.toDouble(),
                alignment: Alignment.center,
              )
            : null,
      ),
    );
  }
}

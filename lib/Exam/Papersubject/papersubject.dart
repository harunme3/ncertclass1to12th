import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/Exam/allpaperlist/allpaperlist.dart';
import 'package:ncertclass1to12th/Exam/exammodal/exammodal.dart';

class PaperSubject extends StatefulWidget {
  const PaperSubject(
      {Key? key,
      required this.boardDataSet,
      required this.boardName,
      required this.classname,
      required this.papertype})
      : super(key: key);

  final BoardDataSet boardDataSet;
  final String boardName;
  final String classname;
  final String papertype;

  @override
  State<PaperSubject> createState() => _PaperSubjectState();
}

class _PaperSubjectState extends State<PaperSubject> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: widget.boardDataSet.subjectDataset.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllPaperList(
                            subjectDataset:
                                widget.boardDataSet.subjectDataset[index],
                            boardName: widget.boardName,
                            classname: widget.classname,
                            papertype: widget.papertype,
                            subjectname: widget
                                .boardDataSet.subjectDataset[index].subjectname,
                          )));
            },
            child: Tooltip(
              textStyle: TextStyle(color: Colors.white),
              message: widget.boardDataSet.subjectDataset[index].subjectname,
              preferBelow: false,
              verticalOffset: size.width / 5,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xFF2f5fe8),
                  const Color(0xFF5b59ec),
                  const Color(0xFF7d50ed),
                  const Color(0xFF9c43ec),
                  const Color(0xFFb82fe8),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [
                        0.10,
                        0.90,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF2f5fe8),
                        Color(0xFFb82fe8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //image
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          widget.boardDataSet.subjectDataset[index]
                              .subjectimagesrc,
                          fit: BoxFit.contain,
                        ),
                      ),
                      //name
                      Container(
                        child: AutoSizeText(
                          widget.boardDataSet.subjectDataset[index].subjectname,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

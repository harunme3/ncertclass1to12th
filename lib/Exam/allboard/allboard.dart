import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/Exam/Papersubject/papersubject.dart';
import 'package:ncertclass1to12th/Exam/exammodal/exammodal.dart';

class AllBoard extends StatefulWidget {
  const AllBoard(
      {Key? key,
      required this.classname,
      required this.examDataset,
      required this.papertype})
      : super(key: key);

  final String classname;
  final ExamDataSet examDataset;
  final String papertype;

  @override
  State<AllBoard> createState() => _AllBoardState();
}

class _AllBoardState extends State<AllBoard> {
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
        itemCount: widget.examDataset.boardDataSet.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaperSubject(
                            boardDataSet:
                                widget.examDataset.boardDataSet[index],
                            boardName: widget
                                .examDataset.boardDataSet[index].boardName,
                            classname: widget.classname,
                            papertype: widget.papertype,
                          )));
            },
            child: Tooltip(
              textStyle: TextStyle(color: Colors.white),
              message: widget.examDataset.boardDataSet[index].boardName,
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
                          widget.examDataset.boardDataSet[index].boardimagesrc,
                          fit: BoxFit.contain,
                        ),
                      ),
                      //name
                      Container(
                        child: AutoSizeText(
                          widget.examDataset.boardDataSet[index].boardName,
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

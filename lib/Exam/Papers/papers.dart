import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/Exam/allboard/allboard.dart';
import 'package:ncertclass1to12th/Exam/paperprovider/paperprovider.dart';
import 'package:ncertclass1to12th/Exam/exammodal/exammodal.dart';
import 'package:provider/provider.dart';

class Papers extends StatefulWidget {
  const Papers({Key? key, required this.classname}) : super(key: key);
  final String classname;
  @override
  State<Papers> createState() => _PapersState();
}

class _PapersState extends State<Papers> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<BoardSet>(
        future: Provider.of<PaperProvider>(context)
            .loadJsonDataSet(widget.classname),
        builder: (BuildContext context, AsyncSnapshot<BoardSet> snapshot) {
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
                return Scaffold(
                  appBar: AppBar(),
                  body: Column(
                    children: [
                      GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: snapshot.data!.examDataSet.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllBoard(
                                        classname: widget.classname,
                                        examDataset:
                                            snapshot.data!.examDataSet[index],
                                        papertype: snapshot.data!
                                            .examDataSet[index].Papertype),
                                  ));
                            },
                            child: Tooltip(
                              textStyle: TextStyle(color: Colors.white),
                              message:
                                  snapshot.data!.examDataSet[index].Papertype,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //image
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          snapshot.data!.examDataSet[index]
                                              .typeimagesrc,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      //name
                                      Container(
                                        child: AutoSizeText(
                                          snapshot.data!.examDataSet[index]
                                              .Papertype,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
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
                    ],
                  ),
                );
          }
        });

    //
  }
}

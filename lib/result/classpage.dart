import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/result/boardpage.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BoardPage(
                            classname: 'Class 10',
                          )));
            },
            child: Container(
              height: size.height / 2,
              width: size.width,
              child: Image.asset('assets/exam/class10thboard.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BoardPage(
                            classname: 'Class 12',
                          )));
            },
            child: Container(
              height: size.height / 2,
              width: size.width,
              child: Image.asset('assets/exam/class10thboard.png'),
            ),
          ),
        ],
      ),
    );
  }
}

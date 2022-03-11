import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.boardname, required this.classname})
      : super(key: key);
  final String boardname;
  final String classname;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Result has been not declare yet'),
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Result has been not declare yet'),
                  ),
                );
              },
              child: Text(
                  'Check Result  ${widget.boardname} of ${widget.classname}'))
        ],
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ncertclass1to12th/Modals/listdata.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

class HintFloatingActionButton extends StatefulWidget {
  HintFloatingActionButton({
    required this.classname,
  });
  final String classname;

  @override
  State<HintFloatingActionButton> createState() =>
      _HintFloatingActionButtonState();
}

class _HintFloatingActionButtonState extends State<HintFloatingActionButton> {
  final d = Logger();

  @override
  Widget build(BuildContext context) {
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
                return FloatingActionButton(
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        'Hint',
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        const Color(0xFF2f5fe8),
                        const Color(0xFF5b59ec),
                        const Color(0xFF7d50ed),
                        const Color(0xFF9c43ec),
                        const Color(0xFFb82fe8),
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    ),
                  ),
                  onPressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => HintPdf(path: '')),
                    // );
                  },
                );
          }
        });
  }
}

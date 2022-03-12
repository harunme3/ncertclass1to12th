import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:logger/logger.dart';
import 'package:ncertclass1to12th/browser/browser.dart';
import 'package:ncertclass1to12th/onlinepdfviewer/onlinepdfviewer.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.boardname, required this.classname})
      : super(key: key);

  final String boardname;
  final String classname;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int count = 0;
  var l = Logger();

  String renderddata(Map<String, dynamic> data) {
    return """
### ${data['note']}
- ${data['resultinfo']}
- ${data['resultdate']}
- ${data['otherinfo1']}
- ${data['process']}
- ${data['examdate']}
- ${data['resultdate']}
- ${data['otherinfo2']}

""";
  }

  Future<Map<String, dynamic>> fetchresultdata() async {
    DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection('Exam')
        .doc(widget.classname)
        .collection(widget.boardname)
        .doc('info')
        .get();
    l.w(ref.data());
    return ref.data()!.values.map((e) => e).toList()[0];
  }

  showresult(List url) {
    count = 0;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: AutoSizeText(
          'Result Server',
          minFontSize: 18,
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        content: Text(
          'If one is not working use other',
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        actions: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: url.map((e) => BuildServer(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildServer(link) {
    return TextButton(
      onPressed: () {
        l.e(link);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppBrowser(
                    url: link,
                  )),
        );
      },
      child: AutoSizeText(
        'Server ${++count}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchresultdata(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
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
                    appBar: AppBar(
                      title: Text('Result'),
                    ),
                    body: ListView(
                      children: [
                        //ads
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              snapshot.data!['status'] == true
                                  ? showresult(snapshot.data!['url'])
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'This Link will be activated after result decalaration '),
                                      ),
                                    );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Check Result Now ',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                        MarkdownBody(
                          data: renderddata(snapshot.data!),
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            textScaleFactor: 1.5,
                            listBullet:
                                TextStyle(color: Colors.red, fontSize: 24),
                            h3: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnlinePdfViwer(
                                          url: snapshot.data!['timetable'],
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Time Table',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
          }
        });
  }
}

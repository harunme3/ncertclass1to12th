import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/pdf%20view/pdf%20view_location.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DownloadedBook extends StatefulWidget {
  DownloadedBook({Key? key}) : super(key: key);

  @override
  State<DownloadedBook> createState() => _DownloadedBookState();
}

class _DownloadedBookState extends State<DownloadedBook> {
  Future<List<String>> fileoperation() async {
    Directory dir = await getApplicationDocumentsDirectory();

    var listofpdf = dir
        .listSync()
        .map((item) => item.path)
        .where((element) => element.endsWith('.pdf'))
        .toList();

    return listofpdf;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return FutureBuilder<List<String>>(
        future: fileoperation(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                //Background page on reload
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                        pinned: true,
                        expandedHeight: 180,
                        flexibleSpace: FlexibleSpaceBar(
                          background: SvgPicture.asset(
                            'assets/header/downloadedbook.svg',
                          ),
                          collapseMode: CollapseMode.pin,
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Downloaded',
                            ),
                          ),
                        ],
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        File file = new File(snapshot.data![index]);
                        List<String> name =
                            file.path.split('/').last.split('_');

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewLocation(file)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
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
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: CircleAvatar(
                                    backgroundColor: isDarkTheme
                                        ? Colors.black
                                        : Colors.white,
                                    child: Text(index.toString(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1),
                                  )),
                                  Flexible(
                                    child: Text(
                                        '${name[0]}>${name[1]}>${name[3]}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: name[2].split(' ').last.trim() ==
                                              'Book'
                                          ? Icon(Icons.menu_book)
                                          : Icon(Icons.border_color))
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: snapshot.data!.length))
                    ],
                  )),
                );
          }
        });
  }
}

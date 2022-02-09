import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ncertclass1to12th/ncertvideos/Models/allplaylistmodel.dart';
import 'package:ncertclass1to12th/ncertvideos/apiservice/apiservice.dart';
import 'package:ncertclass1to12th/ncertvideos/videosncert/playlistvideos.dart';

class AllPlaylist extends StatefulWidget {
  const AllPlaylist({Key? key}) : super(key: key);

  @override
  _AllPlaylistState createState() => _AllPlaylistState();
}

class _AllPlaylistState extends State<AllPlaylist> {
  var l = Logger();

  Future<List<String>> fetchplaylistid() async {
    DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection('playlistid')
        .doc('list')
        .get();
    Map<String, dynamic>? arrayofplaylist = ref.data();
    l.e(arrayofplaylist!['arrayofplaylist']);

    List<String> list = List.from(arrayofplaylist['arrayofplaylist']);

    return list;
  }

  Future<List<List<AllPlaylistModel>>> _initPlaylist() async {
    // final List<String> playlistids = await fetchplaylistid();

    final List<String> playlistids = [
      'PLa6i7rTYARy0w1coaf1myq36-PcyBhyJj',
      'PLa6i7rTYARy1JT1605Yh0YxU3Oc90is5C',
      'PLh7i6AwsWt1sE-fFCPpa9Yvomp3MC4yci',
      'PLuSU7Jf37F-dZb_-FBKDKBK5BgBhgqMhE',
      'PLWz5rJ2EKKc_KamvEnBDJrBptAfQni7Ig',
      'PLzOt3noWLMthJKm8SJl2zmUlJiZp7fzo7',
      'PL342JVRNQxEAcQdnNeN0JmMzfcm6VtLxS'
    ];
    List<List<AllPlaylistModel>> list = [];
    for (var id in playlistids) {
      l.w('map');
      List<AllPlaylistModel> allPlaylistModel =
          await APIService.instance.fetchVideosFromPlaylist(playlistId: id);
      list.add(allPlaylistModel);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<List<AllPlaylistModel>>>(
          future: _initPlaylist(),
          builder:
              (context, AsyncSnapshot<List<List<AllPlaylistModel>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        l.e(snapshot.data![index][0].thumbnailUrl);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaylistVideos(
                              playlistId: snapshot.data![index][0].playlistId,
                              totalvideos: snapshot.data![index][0].totalvideos,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 1),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            //image
                            Container(
                              child: Stack(
                                children: [
                                  Container(
                                    child: Image.network(
                                      snapshot.data![index][0].thumbnailUrl,
                                    ),
                                  ),
                                  //overlay
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0, 1),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          //count
                                          Container(
                                            child: AutoSizeText(
                                              '${snapshot.data![index][0].totalvideos} \n Videos'
                                                  .toString(),
                                              maxLines: 2,
                                              minFontSize: 24,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child: Image.asset(
                                                  'assets/ncertvideos/youtube.png'))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: AutoSizeText(
                                  snapshot.data![index][0].title,
                                  minFontSize: 18,
                                  maxLines: 3,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 8, right: 8),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: AutoSizeText(
                                  snapshot.data![index][0].channelTitle,
                                  maxLines: 1,
                                ),
                              ),
                            )
                            //name
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:ncertclass1to12th/admob/adhelper/adhelper.dart';
import 'package:ncertclass1to12th/ncertvideos/Models/allplaylistmodel.dart';
import 'package:ncertclass1to12th/ncertvideos/apiservice/apiservice.dart';
import 'package:ncertclass1to12th/ncertvideos/videosncert/playlistvideos.dart';

//Globally define load attempt
const int maxFailedLoadAttempts = 3;

class AllPlaylist extends StatefulWidget {
  const AllPlaylist(
      {required this.bookname,
      required this.classname,
      required this.medium,
      required this.subjectname});

  final String bookname;
  final String classname;
  final String medium;
  final String subjectname;

  @override
  _AllPlaylistState createState() => _AllPlaylistState();
}

class _AllPlaylistState extends State<AllPlaylist> {
  String isclicked = "";
  var l = Logger();

  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  Future<List<String>> fetchplaylistid() async {
    String bookname = widget.bookname.split(' ')[0].toUpperCase();
    List<String> list = [];
    CollectionReference<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection('Education')
        .doc('NCERT and Exampler')
        .collection(widget.classname)
        .doc(bookname)
        .collection(widget.subjectname);

    QuerySnapshot<Map<String, dynamic>> snapshot = await ref.get();
    snapshot.docs.forEach((doc) {
      list = list + List.from(doc.data()['playlistId']);
    });
    return list;
  }

  Future<List<String>> filterfetchplaylistid(String medium) async {
    String bookname = widget.bookname.split(' ')[0].toUpperCase();
    List<String> list = [];
    CollectionReference<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection('Education')
        .doc('NCERT and Exampler')
        .collection(widget.classname)
        .doc(bookname)
        .collection(widget.subjectname);

    QuerySnapshot<Map<String, dynamic>> snapshot = await ref.get();
    snapshot.docs.forEach((doc) {
      for (var i = 0; i < doc.data()['language_code'].length; i++) {
        if (doc.data()['language_code'][i] == medium) {
          list.add(doc.data()['playlistId'][i]);
        }
      }
    });

    return list;
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  Future<List<List<AllPlaylistModel>>> _initPlaylist(
      [String medium = ""]) async {
    final List<String> playlistids;
    if (medium == "en" || medium == "hi") {
      playlistids = await filterfetchplaylistid(medium);
    } else {
      playlistids = await fetchplaylistid();
    }

    List<List<AllPlaylistModel>> list = [];
    for (var id in playlistids) {
      List<AllPlaylistModel> allPlaylistModel =
          await APIService.instance.fetchVideosFromPlaylist(playlistId: id);
      if (allPlaylistModel.isNotEmpty) {
        list.add(allPlaylistModel);
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Hindi Voice',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                onTap: () {
                  setState(() {
                    isclicked = "hi";
                  });
                },
              ),
              PopupMenuItem(
                child: Text(
                  'English Voice',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                onTap: () {
                  setState(() {
                    isclicked = "en";
                  });
                },
              ),
              PopupMenuItem(
                child: Text(
                  'All',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                onTap: () {
                  setState(() {
                    isclicked = "";
                  });
                },
              ),
            ],
            icon: Icon(
              Icons.filter_list_outlined,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )
        ],
      ),
      body: FutureBuilder<List<List<AllPlaylistModel>>>(
          future: isclicked == "" ? _initPlaylist() : _initPlaylist(isclicked),
          builder:
              (context, AsyncSnapshot<List<List<AllPlaylistModel>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Container(
                      child: AutoSizeText(
                        'No Videos Found',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _showInterstitialAd();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlaylistVideos(
                                playlistId: snapshot.data![index][0].playlistId,
                                totalvideos:
                                    snapshot.data![index][0].totalvideos,
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
                                                    'assets/videoscources/youtube.png'))
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

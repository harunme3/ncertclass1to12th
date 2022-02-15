import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncertclass1to12th/home/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: size.height / 3,
                width: size.width,
                child: SvgPicture.asset('assets/header/Splashscreen.svg'),
              ),
            ),
            Column(
              children: [
                Container(
                    child: AutoSizeText(
                  'Virtual Study',
                  maxFontSize: 36,
                  minFontSize: 28,
                  textAlign: TextAlign.center,
                )),
                Container(
                  child: AutoSizeText(
                    'NCERT Hindi Class All',
                    maxFontSize: 28,
                    minFontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

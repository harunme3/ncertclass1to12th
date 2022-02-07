import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: size.height / 3,
              width: size.width,
              child: SvgPicture.asset('assets/header/welcome.svg'),
            ),
          ),
          Column(
            children: [
              Container(
                  child: AutoSizeText(
                'Welcome',
                maxFontSize: 36,
                minFontSize: 28,
                textAlign: TextAlign.center,
              )),
              Container(
                child: AutoSizeText(
                  'A reader lives a thousand lives,\nThe man who never reads lives only one',
                  maxFontSize: 28,
                  minFontSize: 18,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

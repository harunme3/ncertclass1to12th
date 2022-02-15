import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ncertclass1to12th/Onboarding/selectlanguage.dart';
import 'package:ncertclass1to12th/Onboarding/lastintropage.dart';
import 'package:ncertclass1to12th/Onboarding/welcomepage.dart';
import 'package:ncertclass1to12th/config/appcolor.dart';
import 'package:ncertclass1to12th/home/home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Home()),
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: AppColor.first_color,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        rawPages: [
          SelectLanguage(),
          Welcome(),
          LastIntroPage(),
        ],

        done: Text('Read', style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text('Skip'),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotDecoration(),
        onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Colors.white,
        skipFlex: 0,
        nextFlex: 0,
        color: AppColor.first_color,
        // isProgressTap: false,
        // isProgress: false,
        // showNextButton: false,
        // freeze: true,
        // animationDuration: 1000,
      ),
    );
  }
}

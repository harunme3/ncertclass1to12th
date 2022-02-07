import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:provider/provider.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int selectedValue = Provider.of<LangaugeProvider>(context).isHindi ? 1 : 0;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: size.height / 3,
              width: size.width,
              child: SvgPicture.asset('assets/header/languageselect.svg'),
            ),
          ),
          Column(
            children: [
              Container(
                  child: AutoSizeText(
                'Select Language',
                maxFontSize: 36,
                minFontSize: 28,
                textAlign: TextAlign.center,
              )),
              Column(
                children: [
                  RadioListTile<int>(
                    value: 0,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      context.setLocale(Locale('en'));
                      print('selected value $value');
                      Provider.of<LangaugeProvider>(context, listen: false)
                          .selectLangauge(false);

                      setState(() {
                        selectedValue = value!;
                      });
                    },
                    title: Text("English"),
                  ),
                  RadioListTile<int>(
                    value: 1,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      print('selected value $value');
                      context.setLocale(Locale('hi'));
                      Provider.of<LangaugeProvider>(context, listen: false)
                          .selectLangauge(true);
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                    title: Text("Hindi"),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

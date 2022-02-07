import 'package:ncertclass1to12th/App_review/app_review.dart';
import 'package:ncertclass1to12th/Correction_Form/correction_form.dart';
import 'package:ncertclass1to12th/pdf%20view/Screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:screenshot/screenshot.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Paneloption extends StatelessWidget {
  Paneloption(
      this.scrollController, this.screenshotController, this.panelController);

  final l = Logger();
  final ScreenshotController screenshotController;
  final ScrollController scrollController;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xFF2f5fe8),
                  const Color(0xFF5b59ec),
                  const Color(0xFF7d50ed),
                  const Color(0xFF9c43ec),
                  const Color(0xFFb82fe8),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () async {
                  final image = await screenshotController.capture();
                  PdfScreenShot.saveandshare(image);
                  panelController.close();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.screenshot_outlined,
                      ),
                    ),
                    Expanded(
                      child: Text('share_screenshot',
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1)
                          .tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xFF2f5fe8),
                  const Color(0xFF5b59ec),
                  const Color(0xFF7d50ed),
                  const Color(0xFF9c43ec),
                  const Color(0xFFb82fe8),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CorrectionForm(),
                    ),
                  );
                  panelController.close();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.forward_to_inbox_outlined,
                      ),
                    ),
                    Expanded(
                      child: Text('report_for_correction',
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1)
                          .tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xFF2f5fe8),
                  const Color(0xFF5b59ec),
                  const Color(0xFF7d50ed),
                  const Color(0xFF9c43ec),
                  const Color(0xFFb82fe8),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () async {
                  AppReview.rateAndReviewApp();
                  panelController.close();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_border_outlined,
                      ),
                    ),
                    Expanded(
                      child: Text('rate_us_msg',
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1)
                          .tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

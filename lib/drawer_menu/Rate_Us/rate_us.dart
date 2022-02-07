import 'package:ncertclass1to12th/App_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RateUs extends StatelessWidget {
  const RateUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(
            Icons.star_border_outlined,
          ),
          SizedBox(
            width: 10,
          ),
          Text('rate_us', style: Theme.of(context).primaryTextTheme.bodyText1)
              .tr()
        ],
      ),
      onTap: () => AppReview.rateAndReviewApp(),
    );
  }
}

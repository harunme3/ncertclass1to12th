import 'package:in_app_review/in_app_review.dart';

class AppReview {
  // actual store listing review & rating
  static void rateAndReviewApp() async {
    final _inAppReview = InAppReview.instance;

    if (await _inAppReview.isAvailable()) {
      print('request actual review from store');
      _inAppReview
          .requestReview()
          .then((value) => {_inAppReview.openStoreListing()});
    }
  }
}

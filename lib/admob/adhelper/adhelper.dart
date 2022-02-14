import 'dart:io';

class AdHelper {
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    }
    {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

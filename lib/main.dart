import 'package:ncertclass1to12th/Exam/paperprovider/paperprovider.dart';
import 'package:ncertclass1to12th/Onboarding/onboarding.dart';
import 'package:ncertclass1to12th/Rough/sideroughstatus.dart';
import 'package:ncertclass1to12th/app_analysis/app_analysis.dart';
import 'package:ncertclass1to12th/langauge/langauge_provider.dart';
import 'package:ncertclass1to12th/notificationlist/localnotificationservice.dart';
import 'package:ncertclass1to12th/notificationlist/pushmessage.dart';
import 'package:ncertclass1to12th/splashScreen/splashScreen.dart';
import 'package:ncertclass1to12th/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  //=========================================================================
  //Widget initlized
  WidgetsFlutterBinding.ensureInitialized();

//=======================================================================
//Disabled Landscope mode

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  //=============================================================================================
  //firebase intilization

  await Firebase.initializeApp();

//=============================================================================================
// theme toggle

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  final themebox = await Hive.openBox('themebox');

  bool isDarkTheme = themebox.get('isDarkTheme') ?? false;

//=============================================================================================
  //langauge toggle

  final languagebox = await Hive.openBox('languagebox');

  bool isHindi = languagebox.get('isHindi') ?? false;

//=============================================================================================
  //app count

  final countbox = await Hive.openBox('countbox');
  int appCount = countbox.get('appcount') ?? 0;

//=============================================================================================
// localization hindi to english and English to Hindi
  await EasyLocalization.ensureInitialized();

//=============================================================================================
//Receive message when app is in background but opened but it work without tap
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

// mode

  return runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('hi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: MultiProvider(providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(isDarkTheme)),
        ChangeNotifierProvider<LangaugeProvider>(
            create: (context) => LangaugeProvider(isHindi)),
        ChangeNotifierProvider<SideRoughStatus>(
            create: (context) => SideRoughStatus(false)),
        ChangeNotifierProvider<AppAnalysisProvider>(
            create: (context) => AppAnalysisProvider(appCount)),
        ChangeNotifierProvider<PaperProvider>(
            create: (context) => PaperProvider()),
      ], child: NcertHome()),
    ),
  );
}

class NcertHome extends StatefulWidget {
  @override
  _NcertHomeState createState() => _NcertHomeState();
}

class _NcertHomeState extends State<NcertHome> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  Future<bool> checkFirstSeen() async {
    final seenbox = await Hive.openBox('seenbox');
    bool isFirstSeen = seenbox.get('isFirstSeen') ?? false;

    if (isFirstSeen) {
      return true;
    } else {
      seenbox.put('isFirstSeen', true);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<ThemeProvider, LangaugeProvider, SideRoughStatus,
        AppAnalysisProvider, PaperProvider>(builder: (
      context,
      themeProvider,
      langaugeProvider,
      sideRoughStatus,
      appAnalysisProvider,
      paperProvider,
      child,
    ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.themeData(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: FutureBuilder(
            future: checkFirstSeen(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SafeArea(
                    child: Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return snapshot.data == true
                        ? SplashScreen()
                        : Onboarding();
              }
            }),
        routes: {
          "nottification": (_) => PushMessagePage(),
        },
      );
    });
  }
}

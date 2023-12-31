import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'helpers/config.dart';
import 'helpers/pref.dart';
import 'firebase_options.dart';

late Size mq;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  //initializing remote config
  // await Config.initConfig();

  await Pref.initializeHive();

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'porxy changer',
      home: SplashScreen(),
      //theme
      theme:
          ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),

      // themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      themeMode: ThemeMode.dark,


      //dark theme
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)),

      debugShowCheckedModeBanner: false,
    );
  }
}

extension AppTheme on ThemeData {
  // Color get lightText => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get lightText =>Colors.black54;
  // Color get bottomNav => Pref.isDarkMode ? Colors.white12 : Colors.blue;
  Color get bottomNav =>Colors.blue;

}



import 'package:dawerf/AuthScreens/WelcomeScreen.dart';
import 'package:dawerf/HomePage.dart';
import 'package:dawerf/HomeScreen/dawer_home.dart';

import 'package:dawerf/AuthScreens/Login.dart';



import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:dawerf/menu.dart';
import 'package:dawerf/report.dart';
import 'firebase_options.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async  {


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(DoctorApp()));
}

class DoctorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: ColorResources.green009),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
      ),
      home: WelcomeScreen(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:my_calculator/pages/loading_page.dart';
//import 'package:my_calculator/pages/login_page.dart';
//import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyTutorialApp());
}

class MyTutorialApp extends StatefulWidget {
  const MyTutorialApp({Key? key}) : super(key: key);

  @override
  State<MyTutorialApp> createState() => _MyTutorialAppState();
}

class _MyTutorialAppState extends State<MyTutorialApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Tutorial Apps',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        // home: SplashScreen(
        //     seconds: 5,
        //     navigateAfterSeconds: LoginPage(),
        //     // ignore: unnecessary_new
        //     title: Text(
        //       'Loading'.toUpperCase(),
        //       // ignore: unnecessary_new
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 20.0,
        //           color: Colors.white),
        //     ),
        //     //image: Image.asset('assets/images/splash.jpg'),
        //     //photoSize: 90.0,
        //     backgroundColor: Color(0xFF28527a),
        //     styleTextUnderTheLoader: TextStyle(),
        //     loaderColor: Colors.white));
        home: LoadingScreen());
  }
}

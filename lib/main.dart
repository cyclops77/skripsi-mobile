import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/view/auth/splash.dart';

void main() {
  configLoading();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..successWidget = Container(
      width: 200,
      child: Icon(CupertinoIcons.checkmark_alt_circle_fill,
          color: Colors.white, size: 40),
    )
    ..indicatorSize = 45.0
    ..errorWidget = Container(
      width: 200,
      child: Icon(CupertinoIcons.exclamationmark_bubble_fill,
          color: Colors.white, size: 40),
    )
    ..radius = 10.0
    ..backgroundColor = Colors.black38
    ..indicatorColor = Colors.black38
    ..textStyle = TextStyle(fontSize: 12, letterSpacing: 1, color: Colors.white)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget child) {
        return FlutterEasyLoading(child: child);
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

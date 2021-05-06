import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/auth/login.dart';
import 'package:flutterapp/view/home/aparatur.dart';
import 'package:flutterapp/view/home/kepdes.dart';
import 'package:flutterapp/view/survey/offline.dart';
import 'package:flutterapp/viewmodel/auth-vm.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void lanjut() {
    Loading.fLoading(
        msg: "Sedang memproses autentikasi anda, silahkan tunggu",
        isClosesable: false);
    AuthVM.cekAuth().then((value) {
      Loading.fClose();
      if (value == 'login') {
        Routes.stfA(context, LoginScreen());
      } else {
        if (value == 'kades') {
          Routes.stfR(context, BerandaKepdesScreen());
        } else if (value == 'aparatur') {
          Routes.stfR(context, BerandaAparaturScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr.white,
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        child: Column(
          children: [
            Verticals(displayHeight(context) * 0.25),
            FlutterLogo(
              size: displayWidth(context) * 0.4,
            ),
            Verticals(displayHeight(context) * 0.05),
            Ctext(
              isi: 'Gumuksari Survey App',
              font: 'c',
              color: Clr.primary,
              weight: FontWeight.w600,
              size: 20,
            ),
            Verticals(displayHeight(context) * 0.035),
            Button(
              fun: () {
                lanjut();
                // Routes.stfA(context, LoginScreen());
              },
              isi: 'Masuk dan Lanjutkan',
              colorText: Clr.white,
              colorButton: Clr.primary.withOpacity(0.75),
              percents: 0.8,
              height: 45,
            ),
            Verticals(7.5),
            Button(
              fun: () {
                Routes.stfA(context, OfflineSurveyScreen());
              },
              isi: 'Survey Offline',
              colorText: Clr.primary.withOpacity(0.75),
              outLine: Clr.primary,
              colorButton: Clr.white,
              percents: 0.8,
              height: 45,
            ),
            Verticals(displayHeight(context) * 0.175),
            Ctext(
              isi:
                  'Aplikasi mobile survey kelayakan\ncalon penerima bantuan\ndana desa',
              font: 'a',
              line: 4,
              arah: TextAlign.center,
              color: Clr.primary,
              weight: FontWeight.w400,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

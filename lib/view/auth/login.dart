import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/input.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/home/aparatur.dart';
import 'package:flutterapp/view/home/kepdes.dart';
import 'package:flutterapp/viewmodel/auth-vm.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  void login() {
    if (email.text == '' || password.text == '') {
      Loading.fFails(msg: "Silahkan masukkan inputan yang ada");
    } else {
      Loading.fLoading(
          msg: "Sedang mengotentikasi email dan password yang anda inputkan",
          isClosesable: false);
      AuthVM.login(email.text, password.text).then((value) {
        Loading.fClose();
        if (value == 'kades') {
          Routes.stfR(context, BerandaKepdesScreen());
        } else if (value == 'aparatur') {
          Routes.stfR(context, BerandaAparaturScreen());
        } else {
          Loading.fFails(msg: value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Clr.white,
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        child: ListView(
          children: [
            Verticals(displayHeight(context) * 0.225),
            FlutterLogo(
              size: displayWidth(context) * 0.4,
            ),
            Verticals(displayHeight(context) * 0.05),
            Ctext(
              arah: TextAlign.center,
              isi: 'Gumuksari Survey App',
              font: 'c',
              color: Clr.primary,
              weight: FontWeight.w600,
              size: 20,
            ),
            Verticals(15),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.1),
              child: Input(
                size: 14,
                controller: email,
                // paddingVertical: 7.5,
                placeholder: "Alamat Email / Username",
                lines: 1,
              ),
            ),
            Verticals(7.5),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.1),
              child: Input(
                size: 14,
                controller: password,
                // paddingVertical: 7.5,
                placeholder: "Password / Kata sandi",
                lines: 1,
                hidden: true,
              ),
            ),
            Verticals(displayHeight(context) * 0.03),
            Column(
              children: [
                Button(
                  fun: () {
                    login();
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
                    Navigator.pop(context);
                  },
                  isi: 'Kembali',
                  height: 45,
                  colorText: Clr.primary.withOpacity(0.75),
                  outLine: Clr.primary,
                  colorButton: Clr.white,
                  percents: 0.8,
                ),
              ],
            ),
            Verticals(20),
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
            Verticals(25),
          ],
        ),
      ),
    );
  }
}

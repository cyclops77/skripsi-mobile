import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/aparatur/buat.dart';
import 'package:flutterapp/view/aparatur/semua.dart';
import 'package:flutterapp/view/auth/splash.dart';
import 'package:flutterapp/view/home/card-menu.dart';
import 'package:flutterapp/view/survey/buat.dart';
import 'package:flutterapp/view/survey/semua.dart';
import 'package:flutterapp/view/widget/modal.dart';
import 'package:flutterapp/viewmodel/auth-vm.dart';
import 'package:flutterapp/viewmodel/spf-vm.dart';

class BerandaKepdesScreen extends StatefulWidget {
  @override
  _BerandaKepdesScreenState createState() => _BerandaKepdesScreenState();
}

class _BerandaKepdesScreenState extends State<BerandaKepdesScreen> {
  void out() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Permission(
        title: 'Peringatan',
        desc: 'Apakah anda yakin untuk keluar dari aplikasi ?',
        cancel: 'Tidak',
        sure: 'Keluar',
        actionSure: () {
          exit(0);
        },
      ),
    );
  }

  String nama;
  bool loading = true;
  void getSP() async {
    String namaA;
    namaA = await SP.getOthers('nama');
    setState(() {
      nama = namaA;
      loading = false;
    });
  }

  @override
  void initState() {
    getSP();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        out();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Clr.white,
        appBar: AppBar(
          backgroundColor: Clr.white,
          leading: Container(),
          title: Ctext(
            isi: "Beranda",
            color: Clr.primary,
            weight: FontWeight.w600,
            font: 'c',
            size: 16,
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Clr.container,
          width: displayWidth(context),
          height: displayHeight(context),
          child: Column(
            children: [
              Verticals(displayHeight(context) * 0.085),
              FlutterLogo(
                size: displayWidth(context) * 0.3,
              ),
              Verticals(25),
              Ctext(
                isi: loading ? "Memuat nama" : nama.toString(),
                font: 'c',
                color: Clr.primary,
                weight: FontWeight.w600,
                size: 16,
              ),
              Verticals(5),
              Ctext(
                isi: 'Kepala Desa',
                font: 'a',
                color: Clr.primary,
                weight: FontWeight.w500,
                size: 11,
              ),
              Verticals(25),
              Container(
                width: displayWidth(context) * 0.875,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardMenu(
                      fun: () {
                        Routes.stfA(context, SemuaAparaturScreen());
                      },
                      nama: "Data Aparatur",
                      icons: CupertinoIcons.at_circle_fill,
                    ),
                    CardMenu(
                      fun: () {
                        Routes.stfA(context, BuatAparaturScreen());
                      },
                      nama: "Buat Aparatur",
                      icons: CupertinoIcons.at_badge_plus,
                    ),
                    CardMenu(
                      fun: () {
                        Routes.stfA(context, SemuaSurveyScreen());
                      },
                      nama: "Data Survey",
                      icons: CupertinoIcons.news_solid,
                    ),
                  ],
                ),
              ),
              Verticals(10),
              Container(
                width: displayWidth(context) * 0.875,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardMenu(
                      fun: () {
                        Routes.stfA(context, BuatSurveyScreen());
                      },
                      nama: "Buat Survey",
                      icons: CupertinoIcons.calendar_badge_plus,
                    ),
                  ],
                ),
              ),
              Verticals(25),
              Button(
                fun: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Permission(
                      title: 'Peringatan',
                      desc: 'Apakah anda yakin untuk logout dari akun ?',
                      cancel: 'Tidak',
                      sure: 'Keluar',
                      actionSure: () async {
                        Loading.fLoading(
                            msg:
                                "Melakukan logout dari otentikasi akun pada aplikasi");
                        Timer(Duration(seconds: 2), () {
                          Loading.fClose();
                          AuthVM.logout().then((value) {
                            Routes.stfR(context, SplashScreen());
                          });
                        });
                      },
                    ),
                  );
                },
                isi: 'Logout',
                colorText: Clr.white,
                colorButton: Clr.primary.withOpacity(0.75),
                height: 45,
                percents: 0.875,
              ),
              Verticals(displayHeight(context) * 0.125),
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
      ),
    );
  }
}

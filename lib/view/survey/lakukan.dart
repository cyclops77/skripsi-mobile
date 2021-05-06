import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/model/survey-all-m.dart';
import 'package:flutterapp/view/home/aparatur.dart';
import 'package:flutterapp/view/survey/card-lakukan.dart';
import 'package:flutterapp/view/survey/detail.dart';
import 'package:flutterapp/viewmodel/spf-vm.dart';
import 'package:flutterapp/viewmodel/survet-vm.dart';
import 'package:intl/intl.dart';

class LakukanSurveyScreen extends StatefulWidget {
  @override
  _LakukanSurveyScreenState createState() => _LakukanSurveyScreenState();
}

class _LakukanSurveyScreenState extends State<LakukanSurveyScreen> {
  String nama;
  void getSP() async {
    String namaA;
    namaA = await SP.getOthers('nama');
    setState(() {
      nama = namaA;
      loading = false;
    });
  }

  bool loading = true;
  List<SurveyModel> data = [];
  List<SurveyModel> dataSelect = [];
  void getSurvey() {
    SurveyVM.getSurveyCurrent().then((value) {
      setState(() {
        data = value;
      });
      for (var item in data) {
        if (item.status == 'belum') {
          setState(() {
            loading = false;
            dataSelect.add(item);
          });
        }
      }
    });
  }

  @override
  void initState() {
    getSP();
    getSurvey();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Clr.white,
        appBar: AppBar(
          backgroundColor: Clr.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Clr.primary),
              onPressed: () {
                Routes.stfR(context, BerandaAparaturScreen());
              }),
          title: Ctext(
            isi: "Survey",
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
            child: ListView(
              children: [
                Verticals(20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) * 0.05),
                  padding: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) * 0.05, vertical: 25),
                  child: Column(
                    children: [
                      Ctext(
                        isi:
                            "Data ini berisikan tentang data hasil survey pada tiap - tiap aparatur desa yang sudah melakukan survey dan belum melakukan survey",
                        font: 'b',
                        size: 12,
                        weight: FontWeight.w600,
                        color: Clr.primary,
                        line: 5,
                      ),
                    ],
                  ),
                ),
                Verticals(10),
                if (loading) ...[
                  Verticals(20),
                  Ctext(
                    isi: "Sedang memuat data survey",
                    font: 'b',
                    arah: TextAlign.center,
                    size: 12,
                    weight: FontWeight.w600,
                    color: Clr.primary,
                  ),
                ] else ...[
                  for (var i = 0; i < dataSelect.length; i++) ...[
                    CardLakukan(
                      fun: () {
                        Routes.stfA(
                            context,
                            DetailSurveyScreen(
                              id: dataSelect[i].id.toString(),
                              nama: dataSelect[i].nama,
                              alamat: dataSelect[i].alamat,
                            ));
                      },
                      tgl: DateFormat('dd MMMM, yyyy')
                          .format(dataSelect[i].tanggal),
                      surveyer: dataSelect[i].nama,
                      aparatur: nama,
                      alamat: dataSelect[i].alamat,
                    ),
                  ]
                ],
                Verticals(20),
              ],
            )));
  }
}

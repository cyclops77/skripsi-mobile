import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/model/survey-all-m.dart';
import 'package:flutterapp/view/survey/card-survey.dart';
import 'package:flutterapp/viewmodel/survet-vm.dart';
import 'package:intl/intl.dart';

class SemuaSurveyScreen extends StatefulWidget {
  @override
  _SemuaSurveyScreenState createState() => _SemuaSurveyScreenState();
}

class _SemuaSurveyScreenState extends State<SemuaSurveyScreen> {
  List<SurveyModel> data = [];
  bool loading = true;
  List<SurveyModel> dataSelect = [];
  List<SurveyModel> dataAll = [];
  List<SurveyModel> dataSudah = [];
  List<SurveyModel> dataBelum = [];
  String pilihan = 'semua';

  void ganti(decission) {
    setState(() {
      pilihan = decission;
    });
    if (decission == 'semua') {
      setState(() {
        dataSelect = data;
      });
    } else if (decission == 'sudah') {
      setState(() {
        dataSelect = dataSudah;
      });
    } else if (decission == 'belum') {
      setState(() {
        dataSelect = dataBelum;
      });
    }
  }

  void getSurvey() {
    SurveyVM.getSurveyAll().then((value) {
      setState(() {
        loading = false;
        data = value;
        dataAll = value;
        dataSelect = value;
      });

      // Belum
      for (var item in data) {
        if (item.status == 'belum') {
          setState(() {
            dataBelum.add(item);
            loading = false;
          });
        }
      }

      // Sudah
      for (var item in data) {
        if (item.status == 'sudah') {
          setState(() {
            dataSudah.add(item);
            loading = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
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
                Navigator.pop(context);
              }),
          title: Ctext(
            isi: "Data Survey",
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
                      Verticals(12.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                            fun: () {
                              ganti('semua');
                            },
                            isi: "Semua",
                            colorText:
                                pilihan == 'semua' ? Clr.white : Clr.primary,
                            height: 30,
                            size: 11,
                            outLine: Clr.primary,
                            percents: 0.21,
                            colorButton:
                                pilihan == 'semua' ? Clr.primary : Clr.white,
                          ),
                          Button(
                            fun: () {
                              ganti('sudah');
                            },
                            isi: "Sudah disurvey",
                            colorText:
                                pilihan == 'sudah' ? Clr.white : Clr.primary,
                            height: 30,
                            size: 11,
                            outLine: Clr.primary,
                            percents: 0.28,
                            colorButton:
                                pilihan == 'sudah' ? Clr.primary : Clr.white,
                          ),
                          Button(
                            fun: () {
                              ganti('belum');
                            },
                            isi: "Belum disurvey",
                            colorText:
                                pilihan == 'belum' ? Clr.white : Clr.primary,
                            height: 30,
                            size: 11,
                            outLine: Clr.primary,
                            percents: 0.28,
                            colorButton:
                                pilihan == 'belum' ? Clr.primary : Clr.white,
                          ),
                        ],
                      )
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
                  if (dataSelect.length == 0) ...[
                    Verticals(25),
                    Ctext(
                      isi: "Tidak ada data",
                      font: 'b',
                      arah: TextAlign.center,
                      size: 12,
                      weight: FontWeight.w600,
                      color: Clr.primary,
                    ),
                  ] else ...[
                    for (var i = 0; i < dataSelect.length; i++) ...[
                      CardSurvey(
                        tgl: DateFormat('dd MMMM, yyyy')
                            .format(dataSelect[i].tanggal),
                        surveyer: dataSelect[i].nama,
                        aparatur: dataSelect[i].user.firstName +
                            " " +
                            dataSelect[i].user.lastName,
                        alamat: dataSelect[i].alamat,
                        sudah: dataSelect[i].status == 'sudah' ? true : false,
                        penghasilan: dataSelect[i].penghasilan != null
                            ? NumberFormat.currency(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: 'Rp ')
                                .format((int.parse(dataSelect[i].penghasilan) *
                                    1000))
                            : null,
                        kualitasDinding: dataSelect[i].kualitasDinding,
                        kualitasLantai: dataSelect[i].kualitasLantai,
                        kualitasAtap: dataSelect[i].kualitasAtap,
                        pendidikanAnak: dataSelect[i].pendidikanAnak,
                        output: dataSelect[i].output,
                        survey: dataSelect[i].surveyRule,
                        update: DateFormat('dd MMMM, yyyy')
                            .format(dataSelect[i].updatedAt),
                      ),
                    ]
                  ]
                ],
                Verticals(20),
              ],
            )));
  }
}

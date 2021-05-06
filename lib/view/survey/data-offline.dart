import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/survey/card-offline.dart';
import 'package:flutterapp/viewmodel/survet-vm.dart';

class DataOfflineScreen extends StatefulWidget {
  final String id, nama, alamat;
  DataOfflineScreen({this.id, this.alamat, this.nama});
  @override
  _DataOfflineScreenState createState() => _DataOfflineScreenState();
}

class _DataOfflineScreenState extends State<DataOfflineScreen> {
  bool loading = true;
  List data = [];
  void getData() async {
    SurveyVM.getSurveyOffline().then((value) {
      print(value.toString());
      setState(() {
        loading = false;
        data = value;
      });
    });
  }

  @override
  void initState() {
    getData();
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
                  Ctext(
                    isi: "Sedang memuat data",
                    font: 'b',
                    size: 12,
                    weight: FontWeight.w600,
                    color: Clr.primary,
                    line: 5,
                  ),
                ] else ...[
                  for (var i = 0; i < data.length; i++) ...[
                    CardOffline(
                      data: data[i],
                      id: widget.id,
                      nama: widget.nama,
                      alamat: widget.alamat,
                    ),
                  ],
                ],
                Verticals(20),
              ],
            )));
  }
}

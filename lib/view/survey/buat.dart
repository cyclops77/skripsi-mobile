import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/input.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/model/users-m.dart';
import 'package:flutterapp/view/survey/semua.dart';
import 'package:flutterapp/viewmodel/survet-vm.dart';
import 'package:flutterapp/viewmodel/users-vm.dart';

class BuatSurveyScreen extends StatefulWidget {
  @override
  _BuatSurveyScreenState createState() => _BuatSurveyScreenState();
}

class _BuatSurveyScreenState extends State<BuatSurveyScreen> {
  List<UsersModel> data = [];
  List<String> listUser = [];
  String userid;
  TextEditingController tglString = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime datetgl;
  DateTime dateAkhir;
  Future<Null> _selectDatetgl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    if (picked != null)
      setState(() {
        datetgl = picked;
        tglString.text = picked.toString().replaceAll(" 00:00:00.000", "");
        // _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  void getUsers() {
    UsersVM.getUserAll().then((value) {
      setState(() {
        data = value;
      });
      for (var item in data) {
        setState(() {
          listUser.add(item.firstName +
              " " +
              item.lastName +
              " ( " +
              item.survey.length.toString() +
              " kali survey ) ");
        });
      }
    });
  }

  void store() {
    if (userid == '') {
      Loading.fFails(msg: "Silahkan pilih aparatur terlebih dahulu");
    } else if (alamat.text == '') {
      Loading.fFails(msg: "Silahkan isi alamat survey terlebih dahulu");
    } else if (nama.text == '') {
      Loading.fFails(msg: "Silahkan isi nama survey terlebih dahulu");
    } else if (tglString.text == '') {
      Loading.fFails(msg: "Silahkan pilih tanggal terlebih dahulu");
    } else {
      Loading.fLoading(msg: "Sedang memvalidasi data");
      SurveyVM.storeSurvey(
        alamat: alamat.text,
        nama: nama.text,
        tanggal: tglString.text,
        userid: userid,
      ).then((value) {
        Loading.fClose();
        if (value['tanggal'] != null) {
          Loading.fFails(msg: value['tanggal'][0].toString());
        } else {
          Loading.fSuccess(msg: "Berhasil membuat data survey.");
          Routes.stfR(context, SemuaSurveyScreen());
        }
      });
    }
  }

  @override
  void initState() {
    getUsers();
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
            isi: "Buat Survey",
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
                            "Data survey ini akan dibagikan kepada aparatur yang telah ditetapkan sebagai pelaku survey",
                        font: 'b',
                        size: 12,
                        weight: FontWeight.w600,
                        color: Clr.primary,
                        line: 5,
                      ),
                      Verticals(35),
                      label('Aparatur Desa'),
                      Verticals(8.5),
                      DropdownSearch(
                        mode: Mode.MENU,
                        maxHeight: 175,
                        items: listUser,
                        onChanged: (v) {
                          //print(v);
                          for (var item in data) {
                            if (item.firstName +
                                    " " +
                                    item.lastName +
                                    " ( " +
                                    item.survey.length.toString() +
                                    " kali survey ) " ==
                                v) {
                              print(item.id.toString());
                              setState(() {
                                userid = item.id.toString();
                              });
                            }
                          }
                        },
                        showSearchBox: true,
                      ),
                      Verticals(15),
                      label('Nama tujuan'),
                      Verticals(8.5),
                      Input(
                        controller: nama,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        placeholder: "Nama orang yang disurvey",
                        size: 12,
                        lines: 1,
                      ),
                      Verticals(15),
                      label('Alamat tujuan'),
                      Verticals(8.5),
                      Input(
                        controller: alamat,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        placeholder: "Alamat orang yang disurvey",
                        size: 12,
                        lines: 3,
                      ),
                      Verticals(15),
                      label('Pilih jadwal survey'),
                      Verticals(8.5),
                      InkWell(
                        onTap: () {
                          _selectDatetgl(context);
                        },
                        child: Input(
                          size: 12,
                          controller: tglString,
                          enabled: false,
                          paddingHorizontal: displayWidth(context) * 0.05,
                          paddingVertical: 5,
                          placeholder: "Pilih tanggal awal",
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      Verticals(25),
                      Button(
                        fun: () {
                          store();
                        },
                        height: 45,
                        size: 13,
                        isi: "Submit",
                        colorButton: Clr.primary.withOpacity(0.75),
                        colorText: Clr.white,
                      ),
                      Verticals(25),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget label(a) {
    return Container(
      width: displayWidth(context),
      child: Ctext(
        isi: a,
        font: 'b',
        size: 12,
        weight: FontWeight.w600,
        color: Clr.primary,
        arah: TextAlign.start,
      ),
    );
  }
}

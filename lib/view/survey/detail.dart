import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/input.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/survey/data-offline.dart';
import 'package:flutterapp/view/survey/lakukan.dart';
import 'package:flutterapp/viewmodel/survet-vm.dart';
import 'package:intl/intl.dart';

class DetailSurveyScreen extends StatefulWidget {
  final Map data;
  final String id, nama, alamat;
  DetailSurveyScreen({this.data, this.id, this.alamat, this.nama});
  @override
  _DetailSurveyScreenState createState() => _DetailSurveyScreenState();
}

class _DetailSurveyScreenState extends State<DetailSurveyScreen> {
  String penghasilanValue,
      dindingValue,
      lantaiValue,
      atapValue,
      pendidikanAnakValue,
      alamatValue,
      namaValue;

  List<String> penghasilan = [
    'Rp. 0 - 250.000',
    'Rp. 250.000 - 500.000',
    'Rp. 500.000 - 750.000',
    'Rp. 750.000 - 1.000.000',
    'Rp. 1.000.000 - 1.500.000',
    'Rp. 1.500.000 - 2.000.000',
  ];
  List<String> dinding = [
    'Terbuka',
    'Bambu',
    'Seng',
    'Kayu',
    'Batu bata',
    'Batako',
  ];
  List<String> lantai = [
    'Tanah',
    'Kayu',
    'Semen',
    'Keramik',
    'Ubin',
  ];
  List<String> atap = [
    'Ijuk',
    'Rumbia',
    'Seng',
    'Asbes',
    'Genteng',
  ];
  List<String> pendidikanAnak = [
    'Tidak sekolah',
    'TK',
    'SD',
    'SMP',
    'SMA',
  ];
  TextEditingController penghasilanC = new TextEditingController();
  void save() {
    if (atapValue == null ||
        penghasilanC.text == '' ||
        pendidikanAnakValue == null ||
        lantaiValue == null ||
        dindingValue == null) {
      Loading.fFails(
          msg:
              'Silahkan pilih terlebih dahulu pilihan kriteria atau pilih menggunakan fitur "Pilih data offline"');
    } else {
      Loading.fLoading(msg: "Sedang melakukan unggah data hasil survey anda");
      SurveyVM.updateSurvey(
        kualitasAtap: atapValue,
        penghasilan: penghasilanC.text,
        pendidikanAnak: pendidikanAnakValue,
        kualitasLantai: lantaiValue,
        kualitasDinding: dindingValue,
        id: widget.id,
      ).then((value) {
        Loading.fClose();
        print(value.toString());
        Loading.fSuccess(msg: value['msg']);
        Routes.stfR(context, LakukanSurveyScreen());
      });
    }
  }

  @override
  void initState() {
    if (widget.data != null) {
      setState(() {
        atapValue = widget.data['atap'];
        penghasilanC.text = widget.data['penghasilan'];
        penghasilanValue = widget.data['penghasilan'];
        pendidikanAnakValue = widget.data['pendidikanAnak'];
        lantaiValue = widget.data['lantai'];
        dindingValue = widget.data['dinding'];
      });
    }
    print(atapValue.toString() + " INI DAH");
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
                      Container(
                        width: displayWidth(context),
                        child: Ctext(
                          isi:
                              "Silahkan isi terlebih dahulu inputan kriteria yang telah dilakukan survey pada tujuan survey yang telah dipilih. Atau bisa menggunakan data yang sudah dibuat secara offline dengan klik button dibawah.",
                          font: 'b',
                          arah: TextAlign.start,
                          size: 12,
                          line: 4,
                          weight: FontWeight.w600,
                          color: Clr.primary,
                        ),
                      ),
                      Verticals(12.5),
                      Button(
                        fun: () {
                          Routes.stfA(
                              context,
                              DataOfflineScreen(
                                id: widget.id,
                                nama: widget.nama,
                                alamat: widget.alamat,
                              ));
                        },
                        isi: 'Pilih data offline',
                        size: 12,
                        height: 35,
                        colorButton: Clr.primary,
                        colorText: Clr.white,
                        // outLine: Clr.primary,
                      )
                    ],
                  ),
                ),
                Verticals(8.5),
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
                      Container(
                        width: displayWidth(context),
                        child: Ctext(
                          isi: "Informsai Tujuan :",
                          font: 'a',
                          arah: TextAlign.start,
                          size: 14,
                          weight: FontWeight.w600,
                          color: Clr.primary,
                        ),
                      ),
                      Verticals(11.5),
                      rows("Nama Tujuan", widget.nama),
                      Verticals(8.5),
                      rows("Alamat Tujuan", widget.alamat),
                    ],
                  ),
                ),
                Verticals(10),
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
                      if (widget.data == null) ...[
                        label('Penghasilan (satuan seribu)'),
                        Verticals(8.5),
                        Input(
                          size: 14,
                          input: TextInputType.number,
                          controller: penghasilanC,
                          paddingVertical: 7.5,
                          lines: 1,
                        ),
                        Verticals(15),
                        label('Kualitas dinding'),
                        Verticals(8.5),
                        DropdownSearch(
                          mode: Mode.MENU,
                          maxHeight: 275,
                          items: dinding,
                          onChanged: (v) {
                            setState(() {
                              dindingValue = v.toString();
                            });
                          },
                          showSearchBox: true,
                        ),
                        Verticals(15),
                        label('Kualitas lantai'),
                        Verticals(8.5),
                        DropdownSearch(
                          mode: Mode.MENU,
                          maxHeight: 275,
                          items: lantai,
                          onChanged: (v) {
                            setState(() {
                              lantaiValue = v.toString();
                            });
                          },
                          showSearchBox: true,
                        ),
                        Verticals(15),
                        label('Kualitas atap'),
                        Verticals(8.5),
                        DropdownSearch(
                          mode: Mode.MENU,
                          maxHeight: 275,
                          items: atap,
                          onChanged: (v) {
                            setState(() {
                              atapValue = v.toString();
                            });
                          },
                          showSearchBox: true,
                        ),
                        Verticals(15),
                        label('Kualitas pendidikan anak'),
                        Verticals(8.5),
                        DropdownSearch(
                          mode: Mode.MENU,
                          maxHeight: 275,
                          items: pendidikanAnak,
                          onChanged: (v) {
                            setState(() {
                              pendidikanAnakValue = v.toString();
                            });
                          },
                          showSearchBox: true,
                        ),
                        Verticals(25),
                      ] else ...[
                        Verticals(15),
                        label('Penghasilan'),
                        Verticals(8.5),
                        fills(NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, symbol: 'Rp ')
                            .format((int.parse(widget.data['penghasilan']) *
                                1000))),
                        // fills("Rp. " + widget.data['penghasilan']),
                        Verticals(15),
                        label('Kualitas dinding'),
                        Verticals(8.5),
                        fills(widget.data['dinding']),
                        Verticals(15),
                        label('Kualitas lantai'),
                        Verticals(8.5),
                        fills(widget.data['lantai']),
                        Verticals(15),
                        label('Kualitas atap'),
                        Verticals(8.5),
                        fills(widget.data['atap']),
                        Verticals(15),
                        label('Kualitas pendidikan anak'),
                        Verticals(8.5),
                        fills(widget.data['pendidikanAnak']),
                      ],
                      Verticals(20),
                      Button(
                        fun: () {
                          save();
                        },
                        height: 45,
                        size: 13,
                        isi: "Unggah data",
                        colorButton: Clr.primary.withOpacity(0.75),
                        colorText: Clr.white,
                      ),
                      Verticals(10),
                    ],
                  ),
                ),
                Verticals(20),
              ],
            )));
  }

  Widget fills(txt) {
    return Container(
      width: displayWidth(context),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Clr.container,
      ),
      child: Ctext(
        isi: txt,
        font: 'b',
        size: 12,
        weight: FontWeight.w600,
        color: Clr.primary,
      ),
    );
  }

  Widget rows(l, r) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: displayWidth(context) * 0.25,
          child: Ctext(
            isi: l,
            font: 'b',
            size: 12,
            weight: FontWeight.w600,
            color: Clr.primary,
          ),
        ),
        Container(
          width: displayWidth(context) * 0.05,
          child: Ctext(
            isi: ':',
            font: 'b',
            size: 12,
            weight: FontWeight.w600,
            color: Clr.primary,
          ),
        ),
        Container(
          width: displayWidth(context) * 0.425,
          child: Ctext(
            isi: r,
            font: 'b',
            size: 12,
            weight: FontWeight.w600,
            color: Clr.primary,
            line: 5,
          ),
        ),
      ],
    );
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

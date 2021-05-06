import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/input.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/viewmodel/spf-vm.dart';

class OfflineSurveyScreen extends StatefulWidget {
  @override
  _OfflineSurveyScreenState createState() => _OfflineSurveyScreenState();
}

class _OfflineSurveyScreenState extends State<OfflineSurveyScreen> {
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
  TextEditingController nama = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  TextEditingController penghasilanC = new TextEditingController();

  void save() async {
    List<String> namaList = await SP.getList('namaList') ?? [];
    List<String> alamatList = await SP.getList('alamatList') ?? [];
    List<String> penghasilanList = await SP.getList('penghasilanList') ?? [];
    List<String> dindingList = await SP.getList('dindingList') ?? [];
    List<String> lantaiList = await SP.getList('lantaiList') ?? [];
    List<String> atapList = await SP.getList('atapList') ?? [];
    List<String> pendidikanAnakList =
        await SP.getList('pendidikanAnakList') ?? [];

    if (namaList.contains(nama.text)) {
      Loading.fFails(msg: "Anda telah menyimpan " + nama.text + " sebelumnya");
    } else if (namaList == null || !namaList.contains(nama.text)) {
      Loading.fLoading(msg: "Sedang meyimpan data", isClosesable: false);
      namaList.add(nama.text);
      alamatList.add(alamat.text == '' ? 'tidak ada' : alamat.text);
      penghasilanList.add(penghasilanC.text);
      dindingList.add(dindingValue);
      lantaiList.add(lantaiValue);
      atapList.add(atapValue);
      pendidikanAnakList.add(pendidikanAnakValue);
      SP.saveList(key: 'namaList', value: namaList);
      SP.saveList(key: 'alamatList', value: alamatList);
      SP.saveList(key: 'penghasilanList', value: penghasilanList);
      SP.saveList(key: 'dindingList', value: dindingList);
      SP.saveList(key: 'lantaiList', value: lantaiList);
      SP.saveList(key: 'atapList', value: atapList);
      SP.saveList(key: 'pendidikanAnakList', value: pendidikanAnakList);
      Loading.fClose();
      Loading.fSuccess(msg: "Berhasil menyimpan data survey offline");
    }
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
            isi: "Survey Offline",
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
                            "Data survey ini akan disimpan dalam storage perangkat milik anda. Anda dapat mengunggah data yang telah diinputkan ketika akan menggunah data ke server",
                        font: 'b',
                        size: 12,
                        weight: FontWeight.w600,
                        color: Clr.primary,
                        line: 5,
                      ),
                      Verticals(25),
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
                      label('Penghasilan (satuan seribu)'),
                      Verticals(8.5),
                      Input(
                        size: 14,
                        input: TextInputType.number,
                        controller: penghasilanC,
                        paddingVertical: 7.5,
                        // placeholder: ,
                        lines: 1,
                      ),
                      // DropdownSearch(
                      //   mode: Mode.MENU,
                      //   maxHeight: 275,
                      //   items: penghasilan,
                      //   onChanged: (v) {
                      //     setState(() {
                      //       penghasilanValue = v.toString();
                      //     });
                      //   },
                      //   showSearchBox: true,
                      // ),
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
                      Button(
                        fun: () {
                          save();
                          Navigator.pop(context);
                        },
                        height: 45,
                        size: 13,
                        isi: "Simpan dan Selesai",
                        colorButton: Clr.primary.withOpacity(0.75),
                        colorText: Clr.white,
                      ),
                      Verticals(8.5),
                      Button(
                        height: 45,
                        size: 13,
                        isi: "Simpan dan Lanjutkan",
                        colorButton: Clr.white,
                        colorText: Clr.primary.withOpacity(0.75),
                        outLine: Clr.primary.withOpacity(0.75),
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

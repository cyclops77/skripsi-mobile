import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/model/users-m.dart';
import 'package:flutterapp/view/aparatur/card-user.dart';
import 'package:flutterapp/viewmodel/users-vm.dart';

class SemuaAparaturScreen extends StatefulWidget {
  @override
  _SemuaAparaturScreenState createState() => _SemuaAparaturScreenState();
}

class _SemuaAparaturScreenState extends State<SemuaAparaturScreen> {
  List<UsersModel> data = [];
  bool loading = true;
  void getData() {
    UsersVM.getUserAll().then((value) {
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
            isi: "Data Aparatur",
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
                            "Data aparatur ini adalah data yang terdaftar pada sistem, pilih menu buat akun aparatur untuk membuat akun aparatur yang baru",
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
                    isi: "Sedang memuat data pengguna sistem",
                    font: 'b',
                    size: 12,
                    weight: FontWeight.w600,
                    color: Clr.primary,
                    arah: TextAlign.center,
                  ),
                ] else ...[
                  for (var i = 0; i < data.length; i++) ...[
                    CardUser(
                      nama: data[i].firstName + " " + data[i].lastName,
                      email: data[i].email,
                      username: "@" + data[i].username,
                    ),
                  ]
                ],
                Verticals(20),
              ],
            )));
  }
}

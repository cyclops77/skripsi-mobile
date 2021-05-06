import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/input.dart';
import 'package:flutterapp/core/loading.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/aparatur/semua.dart';
import 'package:flutterapp/viewmodel/users-vm.dart';

class BuatAparaturScreen extends StatefulWidget {
  @override
  _BuatAparaturScreenState createState() => _BuatAparaturScreenState();
}

class _BuatAparaturScreenState extends State<BuatAparaturScreen> {
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  void store() {
    if (firstname.text == '' ||
        lastname.text == '' ||
        email.text == '' ||
        username.text == '' ||
        password.text == '') {
      Loading.fFails(msg: "Silahkan isi form terlebih dahulu");
    } else {
      Loading.fLoading(msg: "Sedang memvalidasi data inputan anda");
      UsersVM.store(
        firstname: firstname.text,
        lastname: lastname.text,
        email: email.text,
        username: username.text,
        password: password.text,
      ).then((value) {
        Loading.fClose();
        if (value['email'] != null) {
          Loading.fFails(msg: value['email'][0].toString());
        } else if (value['username'] != null) {
          Loading.fFails(msg: value['username'][0].toString());
        } else {
          Loading.fSuccess(msg: "Berhasil membuat akun untuk aparatur desa.");
          Routes.stfR(context, SemuaAparaturScreen());
        }
      });
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
            isi: "Buat Aparatur",
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
                            "Data aparatur ini akan digunakan oleh aparatur dalam proses otentikasi akun mereka",
                        font: 'b',
                        size: 12,
                        weight: FontWeight.w600,
                        color: Clr.primary,
                        line: 5,
                      ),
                      Verticals(35),
                      label('Nama depan aparatur'),
                      Verticals(8.5),
                      Input(
                        controller: firstname,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        placeholder: "Nama depan akun aparatur",
                        size: 12,
                        lines: 1,
                      ),
                      Verticals(15),
                      label('Nama belakang aparatur'),
                      Verticals(8.5),
                      Input(
                        controller: lastname,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        placeholder: "Nama belakang akun aparatur",
                        size: 12,
                        lines: 1,
                      ),
                      Verticals(15),
                      label('Email aparatur'),
                      Verticals(8.5),
                      Input(
                        controller: email,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        placeholder: "Email akun aparatur",
                        size: 12,
                        lines: 1,
                      ),
                      Verticals(15),
                      label('Username aparatur'),
                      Verticals(8.5),
                      Input(
                        controller: username,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        placeholder: "Username akun aparatur",
                        size: 12,
                        lines: 1,
                      ),
                      Verticals(15),
                      label('Password aparatur'),
                      Verticals(8.5),
                      Input(
                        controller: password,
                        paddingHorizontal: displayWidth(context) * 0.05,
                        paddingVertical: 5,
                        hidden: true,
                        placeholder: "Password akun aparatur",
                        lines: 1,
                        size: 12,
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

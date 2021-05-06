import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';

class CardUser extends StatelessWidget {
  final String nama, username, email;
  CardUser({this.email, this.nama, this.username});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(
          displayWidth(context) * 0.05, 0, displayWidth(context) * 0.05, 10),
      padding: EdgeInsets.symmetric(
          horizontal: displayWidth(context) * 0.05, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ctext(
            isi: nama,
            font: 'b',
            size: 12,
            weight: FontWeight.w600,
            color: Clr.primary,
            line: 5,
          ),
          Verticals(8.5),
          Ctext(
            isi: email,
            font: 'b',
            size: 11,
            weight: FontWeight.w600,
            color: Clr.primary,
            line: 1,
          ),
          Verticals(5),
          Ctext(
            isi: username,
            font: 'b',
            size: 11,
            weight: FontWeight.w600,
            color: Clr.primary,
            line: 1,
          ),
        ],
      ),
    );
  }
}

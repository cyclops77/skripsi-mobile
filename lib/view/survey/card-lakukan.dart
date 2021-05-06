import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';

class CardLakukan extends StatefulWidget {
  final Function fun;
  final String tgl, aparatur, surveyer, alamat;
  CardLakukan({this.fun, this.tgl, this.aparatur, this.surveyer, this.alamat});

  @override
  _CardLakukanState createState() => _CardLakukanState();
}

class _CardLakukanState extends State<CardLakukan> {
  @override
  Widget build(BuildContext context) {
    rows(l, r) {
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

    return InkWell(
      onTap: widget.fun,
      child: Container(
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
              isi: widget.tgl,
              font: 'b',
              size: 12,
              weight: FontWeight.w600,
              color: Clr.primary,
              line: 5,
            ),
            Container(
              width: displayWidth(context) * 0.875,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Verticals(8.5),
                      rows('Aparatur', widget.aparatur),
                      Verticals(4.5),
                      rows('Nama Tujuan', widget.surveyer),
                      Verticals(4.5),
                      rows('Alamat Tujuan', widget.alamat),
                    ],
                  ),
                  Icon(Icons.chevron_right, size: 24, color: Clr.primary)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/href.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';
import 'package:flutterapp/view/survey/detail.dart';

class CardOffline extends StatefulWidget {
  final Map data;
  final String id, nama, alamat;
  CardOffline({this.data, this.id, this.alamat, this.nama});
  @override
  _CardOfflineState createState() => _CardOfflineState();
}

class _CardOfflineState extends State<CardOffline> {
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
      onTap: () {
        Routes.stfR(
            context,
            DetailSurveyScreen(
              data: widget.data,
              id: widget.id,
              nama: widget.nama,
              alamat: widget.alamat,
            ));
      },
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
              isi: "Data milik " + widget.data['nama'],
              font: 'b',
              size: 12,
              weight: FontWeight.w600,
              color: Clr.primary,
              line: 2,
            ),
            Ctext(
              isi: "Alamat " + widget.data['alamat'],
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
                      rows('penghasilan', widget.data['penghasilan']),
                      Verticals(4.5),
                      rows('dinding', widget.data['dinding']),
                      Verticals(4.5),
                      rows('lantai', widget.data['lantai']),
                      Verticals(4.5),
                      rows('atap', widget.data['atap']),
                      Verticals(4.5),
                      rows('pendidikan', widget.data['pendidikanAnak']),
                      Verticals(4.5),
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

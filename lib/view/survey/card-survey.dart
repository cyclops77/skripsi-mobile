import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';

class CardSurvey extends StatefulWidget {
  final List survey;
  final String tgl,
      aparatur,
      surveyer,
      alamat,
      penghasilan,
      kualitasDinding,
      kualitasLantai,
      kualitasAtap,
      update,
      output,
      pendidikanAnak;

  final bool sudah;
  CardSurvey({
    this.tgl,
    this.survey,
    this.aparatur,
    this.surveyer,
    this.alamat,
    this.sudah,
    this.penghasilan,
    this.kualitasDinding,
    this.kualitasLantai,
    this.kualitasAtap,
    this.pendidikanAnak,
    this.update,
    this.output,
  });

  @override
  _CardSurveyState createState() => _CardSurveyState();
}

class _CardSurveyState extends State<CardSurvey> {
  bool open = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rows(l, r) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: displayWidth(context) * 0.275,
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
            width: displayWidth(context) * 0.45,
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
          Container(
            width: displayWidth(context) * 0.875,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: displayWidth(context) * 0.3,
                  child: Ctext(
                    isi: widget.tgl,
                    font: 'b',
                    size: 12,
                    weight: FontWeight.w600,
                    color: Clr.primary,
                    line: 5,
                  ),
                ),
                Button(
                  percents: 0.215,
                  size: 10,
                  height: 25,
                  colorButton: widget.sudah ? Clr.primary : Clr.danger,
                  colorText: Clr.white,
                  isi: widget.sudah ? "Sudah Survey" : "Belum Survey",
                )
              ],
            ),
          ),
          Verticals(8.5),
          rows('Aparatur', widget.aparatur),
          Verticals(4.5),
          rows('Nama Tujuan', widget.surveyer),
          Verticals(4.5),
          rows('Alamat Tujuan', widget.alamat),
          if (widget.sudah) ...[
            Verticals(15),
            Button(
              fun: () {
                if (open) {
                  setState(() {
                    open = false;
                  });
                } else {
                  setState(() {
                    open = true;
                  });
                }
              },
              height: 30,
              size: 12,
              isi: open ? "Tutup" : "Detail",
              colorButton: Clr.white,
              colorText: Clr.primary,
              outLine: Clr.primary,
            ),
            if (open) ...[
              Verticals(8.5),
              rows('Disurvey pada', widget.update),
              Verticals(4.5),
              rows('Hasil', widget.output),
              Verticals(4.5),
              rows('Penghasilan', widget.penghasilan),
              Verticals(4.5),
              rows('Kualitas dinding', widget.kualitasDinding),
              Verticals(4.5),
              rows('Kualitas lantai', widget.kualitasLantai),
              Verticals(4.5),
              rows('Kualitas atap', widget.kualitasAtap),
              Verticals(4.5),
              rows('Pendidikan anak', widget.pendidikanAnak),
              Verticals(4.5),
              rows('Keputusan',
                  double.parse(widget.output) >= 30 ? 'Layak' : 'Tidak Layak'),
              Verticals(4.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context) * 0.275,
                    child: Ctext(
                      isi: "Rule",
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
                    width: displayWidth(context) * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item in widget.survey) ...{
                          Ctext(
                            isi: "Rule [ " + item.number.toString() + " ]",
                            font: 'b',
                            size: 12,
                            weight: FontWeight.w600,
                            color: Clr.primary,
                            line: 5,
                          ),
                        }
                      ],
                    ),
                  ),
                ],
              )
            ]
          ]
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';

class CardMenu extends StatelessWidget {
  final IconData icons;
  final String nama;
  final Function fun;
  CardMenu({this.icons, this.nama, this.fun});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        width: displayWidth(context) * 0.275,
        height: displayWidth(context) * 0.275,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: Clr.primary,
              size: 36,
            ),
            Verticals(7.5),
            Ctext(
              isi: nama,
              color: Clr.primary,
              size: 11,
              weight: FontWeight.w500,
              font: 'a',
            )
          ],
        ),
        decoration: BoxDecoration(
            // border: Border.all(width: 1, color: Clr.primary),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(7.5))),
      ),
    );
  }
}

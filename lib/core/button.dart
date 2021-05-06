import 'package:flutter/material.dart';
import 'package:flutterapp/core/size.dart';
import 'package:flutterapp/core/sizebox.dart';

class Button extends StatelessWidget {
  final Color colorButton, colorText, outLine;
  final String isi;
  final IconData icon;
  final double percents, height, radius, size;
  final Function long;
  final Function fun;
  Button({
    this.fun,
    this.long,
    this.icon,
    this.colorButton,
    this.colorText,
    this.isi,
    this.percents = 1,
    this.outLine = Colors.transparent,
    this.height = 50,
    this.radius = 10,
    this.size = 14,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: long,
      onTap: fun,
      child: Container(
        alignment: Alignment.center,
        width: displayWidth(context) * percents,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isi,
              style: TextStyle(
                  fontFamily: "popin", color: colorText, fontSize: size),
            ),
            if (icon != null) ...[
              Horizontals(10),
              Icon(
                icon,
                color: colorText,
                size: size,
              )
            ]
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: outLine),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: colorButton,
        ),
      ),
    );
  }
}

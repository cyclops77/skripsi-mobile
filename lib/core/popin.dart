import 'package:flutter/material.dart';

class Ctext extends StatelessWidget {
  final String isi, font;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign arah;
  final int line;

  Ctext(
      {this.isi,
      this.font = 'a',
      this.size,
      this.weight,
      this.color = Colors.black,
      this.arah = TextAlign.start,
      this.line = 1});
  @override
  Widget build(BuildContext context) {
    return Text(isi.toString(),
        maxLines: line,
        overflow: TextOverflow.ellipsis,
        textAlign: arah,
        style: TextStyle(
          fontFamily: font,
          fontSize: size,
          color: color,
          letterSpacing: 1,
          fontWeight: weight,
        ));
  }
}

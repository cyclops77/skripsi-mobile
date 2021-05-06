import 'package:flutter/material.dart';
import 'package:flutterapp/core/button.dart';
import 'package:flutterapp/core/color.dart';
import 'package:flutterapp/core/popin.dart';
import 'package:flutterapp/core/size.dart';

class Permission extends StatelessWidget {
  final String title, desc, cancel, sure;
  final Function actionSure;

  Permission({
    this.actionSure,
    this.title,
    this.desc,
    this.cancel,
    this.sure,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: displayWidth(context) * 0.06),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Ctext(
                    isi: title,
                    color: Colors.black,
                    size: 20,
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    Ctext(
                      isi: desc,
                      color: Clr.black,
                      line: 5,
                      // arah: TextAlign.center,
                      size: 11,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Button(
                    fun: () {
                      Navigator.pop(context);
                    },
                    outLine: Clr.primary,
                    colorButton: Clr.white,
                    colorText: Clr.primary,
                    isi: cancel,
                    percents: 0.335,
                    height: 40,
                    size: 12,
                  ),
                  Button(
                    fun: () {
                      actionSure();
                    },
                    colorButton: Clr.primary,
                    colorText: Clr.white,
                    isi: sure,
                    percents: 0.335,
                    height: 40,
                    size: 12,
                  )
                ],
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ],
    );
  }
}

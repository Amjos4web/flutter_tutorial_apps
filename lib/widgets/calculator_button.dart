// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  const CalculatorButton({
    required this.text,
    required this.fillColor,
    required this.textColor,
    required this.textSize,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: ElevatedButton(
              onPressed: () => {callback(text)},
              style: ElevatedButton.styleFrom(primary: Color(fillColor)),
              child: Text(
                text,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontSize: textSize,
                    color: Color(textColor),
                  ),
                ),
              )),
        ));
  }
}

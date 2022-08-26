

import 'package:flutter/material.dart';

class ProjectTextStyle{
  static TextStyle textStyle({double fontSize = 16, bool isBold= false,Color color = Colors.black}){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : null,
      color: color,
      fontFamily: 'Roboto',
    );
  }
}
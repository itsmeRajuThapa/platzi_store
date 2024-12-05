import 'package:flutter/material.dart';

Widget BoldText(
    {required String title,
    double? fontsize = 25.0,
    Color? color = Colors.black}) {
  return Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: fontsize, color: color),
  );
}

Widget SimpleText(
    {required String title,
    double? fontsize = 18.0,
    Color? color = Colors.black}) {
  return Text(
    title,
    style: TextStyle(fontSize: fontsize, color: color),
  );
}

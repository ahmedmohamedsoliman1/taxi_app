import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textWidget ({String text = "" , double fontSize = 12 , FontWeight fontWeight = FontWeight.normal ,
Color color = Colors.black}){
  return Text(text , style: TextStyle(fontSize: fontSize , fontWeight: fontWeight , color: color),);
}
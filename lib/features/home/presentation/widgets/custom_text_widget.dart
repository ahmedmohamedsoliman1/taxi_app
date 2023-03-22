import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

Widget customTextWidget(
    {String text,
    double fontSize,
    FontWeight fontWeight,
    Function onPressed,
    Color color ,
    bool isVisible = false}){

  return Row(
    children: [
      InkWell(
        onTap: onPressed,
          child: Text (text , style: TextStyle (fontSize: fontSize , fontWeight: fontWeight , color: color),)),
      SizedBox(width: 7,),
      isVisible ? CircleAvatar(radius: 15, backgroundColor: AppColors.primaryColor, child: Text("1"),) : Container()
    ],
  );
}
import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

Widget containerWidget (BuildContext context , String text){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
    height: MediaQuery.of(context).size.height*0.06,
    margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white ,
        boxShadow: [
          BoxShadow(
            color: Colors.black12 ,
            spreadRadius: 2 ,
            blurRadius: 2 ,
            offset: Offset.fromDirection(2)
          )
        ]
      ),
    child: Text(text , style: TextStyle(color: AppColors.primaryColor , fontSize: 18),),
  );
}
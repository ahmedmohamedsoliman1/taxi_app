import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import 'package:taxi_app/features/authontication/presentation/widgets/text_widget.dart';

Widget ElevatedButtonWidget (Function onPressed , BuildContext context , String text ,
IconData icon ){

  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.height * 0.09,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2 ,
          spreadRadius: 2 ,
        )
      ]
    ),
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
             width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration (
                color: AppColors.primaryColor ,
              ),
              child: Container(
                width: 20,
                height: 20,
                child: Icon(icon , size: 30,)
              ),
            ),
            textWidget(text: text , color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold)
          ],
        )),
  );
}
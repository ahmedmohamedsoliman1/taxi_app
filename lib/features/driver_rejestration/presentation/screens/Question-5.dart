import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class Question_five extends StatefulWidget {

  @override
  State<Question_five> createState() => _Question_fiveState();
}

class _Question_fiveState extends State<Question_five> {
  String date = "" ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget (text: "What is the vehicle model year ?" , color: Colors.black ,
              fontWeight: FontWeight.bold , fontSize: 20),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: ()async{
                  date =  await SimpleMonthYearPicker.showMonthYearPickerDialog(
                  selectionColor: AppColors.primaryColor,
                  barrierDismissible: true,
                  context: context,
                  titleFontFamily: 'Rajdhani',
                );
              }, child: Text("Select year" , style: TextStyle(color: Colors.white ,
                  fontWeight: FontWeight.bold , fontSize: 20),) , style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor
              ),),
            ],
          ) ,
          SizedBox(height: 20,),
          // date !=  null ? Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //           color: Colors.white ,
          //           boxShadow: [
          //             BoxShadow(
          //                 color: Colors.black.withOpacity(0.1),
          //                 spreadRadius: 2 ,
          //                 blurRadius: 2
          //             ),
          //           ]
          //       ),
          //       child: Text("", style: TextStyle(color: AppColors.primaryColor , fontSize: 20),),
          //     ),
          //   ],
          // ) :Container()
          Container()
        ],
      ),
    );
  }
}
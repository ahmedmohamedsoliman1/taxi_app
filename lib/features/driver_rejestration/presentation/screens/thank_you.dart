import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class ThankYou extends StatefulWidget {

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        children: [
          SizedBox(height: 30,),
          Icon(Icons.face_outlined , size: 80,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget (text: "Thank you for completing the registration detail" , color: Colors.black ,
                  fontWeight: FontWeight.bold , fontSize: 20),
            ],
          ),
        ],
      ),
    );
  }
}
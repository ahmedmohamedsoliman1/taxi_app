import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';

class Question_three extends StatefulWidget {

  @override
  State<Question_three> createState() => _Question_threeState();
}

class _Question_threeState extends State<Question_three> {
  List<String> makes = ["Honda" , "GMC" , "Kia" , "Ford" , "Toyota"] ;
  int selectedChoice = 0 ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget (text: "What make of vehicle is it ?" , color: Colors.black ,
              fontWeight: FontWeight.bold , fontSize: 20),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context , index) => SizedBox(height: 20,),
                  itemCount: makes.length,
                  itemBuilder: (context , index) => InkWell(
                    onTap: (){
                      selectedChoice = index ;
                      setState(() {

                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: makes[index] , color: Colors.black ,
                            fontWeight: FontWeight.w500 , fontSize: 18) ,
                       selectedChoice == index ? CircleAvatar(
                         radius: 15,
                         backgroundColor: AppColors.primaryColor,
                         child: Icon(Icons.check , color: Colors.white, size: 20,),):
                           Container()
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
class Question_two extends StatefulWidget {

  @override
  State<Question_two> createState() => _Question_twoState();
}

class _Question_twoState extends State<Question_two> {
  List<String> types = ["Economi" , "Business" , "Middle"] ;
  int selectedChoice = 0 ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget (text: "What type of vehicle is it ?" , color: Colors.black ,
              fontWeight: FontWeight.bold , fontSize: 20),
          Expanded(
              child: ListView.separated(
                separatorBuilder: (context , index) => SizedBox(height: 20,),
                  itemCount: types.length,
                  itemBuilder: (context , index) => InkWell(
                    onTap: (){
                      selectedChoice = index ;
                      setState(() {

                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: types[index] , color: Colors.black ,
                            fontWeight: FontWeight.w500 , fontSize: 18) ,
                       selectedChoice == index ?  CircleAvatar(
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
class Question_one extends StatefulWidget {

  @override
  State<Question_one> createState() => _Question_oneState();
}

class _Question_oneState extends State<Question_one> {
  List<String> locations = ["Pakistan" , "Japan" , "USA" , "Quatar"] ;
  int selectedChoice = 0 ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column (
        children: [
          textWidget (text: "What service location you want to register ?" , color: Colors.black ,
              fontWeight: FontWeight.bold , fontSize: 20),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context , index) => SizedBox(height: 20,),
                  itemCount: locations.length,
                  itemBuilder: (context , index) => InkWell(
                    onTap: (){
                      selectedChoice = index ;
                      setState((){});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: locations[index] , color: Colors.black ,
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

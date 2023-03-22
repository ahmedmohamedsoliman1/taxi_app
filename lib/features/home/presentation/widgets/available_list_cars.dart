import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';

class AvaialbleListCars extends StatefulWidget{
  @override
  State<AvaialbleListCars> createState() => _AvaialbleListCarsState();
}

class _AvaialbleListCarsState extends State<AvaialbleListCars> {
  int selected = 0 ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,
      child: Expanded(
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context , index) => InkWell(
              onTap: (){
                selected = index ;
                setState((){});
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height*0.2,
                decoration: BoxDecoration(
                  color: selected == index ? AppColors.primaryColor : Colors.grey ,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack (
                  children: [
                    Positioned(
                        right: -20,
                        top: 0 ,
                        bottom: 0,
                        child: Image(image: AssetImage ("assets/images/car.png"),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          textWidget(text: "Standart" , color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),
                          SizedBox(height: 8,),
                          textWidget(text: "9.92 \$" , color: Colors.white , fontSize: 15 , fontWeight: FontWeight.w400),
                          SizedBox(height: 8,),
                          textWidget(text: "3 MIN" , color: Colors.white , fontSize: 15 , fontWeight: FontWeight.w400)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            separatorBuilder: (context , index) => SizedBox(width: 20,),
            itemCount: 4),
      ),
    );
  }
}
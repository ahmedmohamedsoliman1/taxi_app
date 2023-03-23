import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/features/authontication/presentation/widgets/text_widget.dart';

import '../../../../core/app_colors.dart';
import '../../../payment/presentation/screens/payment_cards_screen.dart';
import 'available_list_cars.dart';

class BottomSheetAvailableCarsWidget extends StatefulWidget{

  @override
  State<BottomSheetAvailableCarsWidget> createState() => _BottomSheetAvailableCarsWidgetState();
}

class _BottomSheetAvailableCarsWidgetState extends State<BottomSheetAvailableCarsWidget> {

  List<String> dropDownList = ["**** **** **** 8751" ,
    "**** **** **** 4628" , "**** **** **** 3264" , "**** **** **** 2569"] ;
  String selectedItem = "**** **** **** 8751";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30 , horizontal: 15),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          textWidget(text: "Select an option: " , color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold),
         SizedBox(height: 30,),
          AvaialbleListCars (),
          Spacer(),
          Divider(color: Colors.black, thickness: 0.5,),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(text: "VISA" , color: Colors.indigo , fontWeight: FontWeight.bold , fontSize: 20),
              SizedBox(width: 10,),
              DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down , size: 30,),
                value: selectedItem,
                  items: dropDownList.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                      child: textWidget(text: value)  , value: value,),).toList(),
                  onChanged: (value){
                    selectedItem = value ;
                    setState(() {

                    });
                  }),
              SizedBox(width: 15,),
              ElevatedButton(
                  onPressed: (){
                      Navigator.pushNamed(context, PaymentCardsScreen.routeName);
                  },
                  child: Text ("Confirm") , style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor , shape: StadiumBorder()),)
            ],
          ),
          Spacer(),

        ],
      ),
    );
  }
}
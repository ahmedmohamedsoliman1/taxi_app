import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../../core/app_colors.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';

class PaymentCardsScreen extends StatelessWidget{

  static const String routeName = "payment_cards";

  String cardNumber ="" ;
  String expiryDate ="" ;
  String cardHolderName = "" ;
  String cvvCode ="" ;
  bool isCvvFocused = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.5,
            decoration: BoxDecoration (
                image: DecorationImage (
                    image: AssetImage ("assets/images/Background_credit.png"),
                    fit: BoxFit.fill
                )
            ),
          ) ,
          Positioned(
            top: 80,
            left: 50,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back , color: AppColors.primaryColor,)),
                      ),
                      SizedBox(width: 20,),
                      textWidget (text: "Add credit card" , color: Colors.white , fontSize: 22 ,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 80,
            left: 0,
            right: 0,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context , index) => Container(
                  width: MediaQuery.of(context).size.width,
                  child: CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    onCreditCardWidgetChange: (CreditCardBrand creditCardBrand){

                    },
                    bankName: "Flutter bank",//
                    isHolderNameVisible: true,//
                    obscureCardNumber: true,// tr
                    cardType: CardType.mastercard,
                    obscureCardCvv: true,// ue when you want to show cvv(back) view
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textWidget(text: "Add new card" , color: AppColors.primaryColor , fontWeight: FontWeight.bold ,
                      fontSize: 22),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                      onPressed: (){

                      } ,
                  child: Icon(Icons.add , size: 25 , color: Colors.white,),)
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
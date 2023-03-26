import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/features/driver_rejestration/presentation/screens/thank_you.dart';
import '../../../../core/app_colors.dart';
import 'Question-1.dart';
import 'Question-2.dart';
import 'Question-3.dart';
import 'Question-5.dart';
import 'Question_4.dart';

class CompleteDreinerRegisterationOne extends StatelessWidget{

  static const String routeName = "complete_one" ;
  PageController pageController = PageController();
  int pageNumber = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Column (
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage (
                        image: AssetImage ("assets/images/Background.png") ,
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " Car Registeration \n" , style: TextStyle(color: Colors.white , fontSize: 23 ,
                                  fontWeight: FontWeight.bold ),
                              ),
                              TextSpan(
                                text:  "complete the process detail" , style: TextStyle(color: Colors.white , fontSize: 16 ,
                                  fontWeight: FontWeight.w500),
                              )
                            ]
                          ),
                      ),
                    ),
                  )
              ),
            ],
          ),
          Expanded(
              child: PageView(
                onPageChanged: (int page){
                  pageNumber = page ;
                },
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Question_one() ,
                  Question_two() ,
                  Question_three (),
                  Question_four (),
                  Question_five (),
                  ThankYou()
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                    onPressed: (){
                   pageController.animateToPage(pageNumber+1, duration: Duration(
                     seconds: 1
                   ), curve: Curves.ease);
                } ,
                child: Icon (Icons.arrow_forward , color: Colors.white,),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
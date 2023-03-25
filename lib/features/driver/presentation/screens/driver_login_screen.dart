import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_strings.dart';
import 'package:taxi_app/features/authontication/presentation/screens/otp_screen.dart';
import 'package:taxi_app/features/authontication/presentation/widgets/text_widget.dart';
import 'package:taxi_app/features/driver/presentation/screens/driver_otp_screen.dart';
import '../../../../core/app_colors.dart';
import '../../../authontication/presentation/widgets/back_ground_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';

class DriverLoginScreen extends StatefulWidget{

  static const String routeName = "driver_login";
  static String verify = "" ;

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {

  String phone = "" ;

  CountryCode countryCode = CountryCode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BackGroundWidget() ,
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: textWidget(text: AppStrings.nict_to_meet),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                child: textWidget(text: AppStrings.get_moving , fontSize: 22 , fontWeight:  FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white ,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 3 ,
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.08),

                      )
                    ]
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: CountryCodePicker(
                            onChanged: (code){
                              setState((){
                                countryCode = code ;
                              });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'IT',
                            favorite: ['+39','FR'],
                            // optional. Shows only country name and flag
                            showCountryOnly: true,
                            showFlag: true,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                            showDropDownButton: true,
                          ),
                        )),
                    Container(width: 8, color: Colors.black.withOpacity(0.1),),
                    Expanded(
                        flex: 4,
                        child: TextFormField(
                          onChanged: (value){
                            phone = value ;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () async{
                                    await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber: '${countryCode.dialCode + phone}',
                                      verificationCompleted: (PhoneAuthCredential credential) {},
                                      verificationFailed: (FirebaseAuthException e) {},
                                      codeSent: (String verificationId, int resendToken) {
                                        DriverLoginScreen.verify = verificationId ;
                                      },
                                      codeAutoRetrievalTimeout: (String verificationId) {},
                                    );
                                    Navigator.pushNamed(context, DriverOTPScreen.routeName , arguments: {
                                      "phone" : phone
                                    });
                                  },
                                  child: Icon(Icons.arrow_forward , color: AppColors.primaryColor,)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              border: InputBorder.none,
                              hintText: AppStrings.enter_mobile
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        children: [
                          TextSpan(
                            text: AppStrings.by_creating + " ",
                          ),
                          TextSpan(
                              text: AppStrings.terms_of,
                              style: TextStyle(color: Colors.black , fontSize: 17 , fontWeight: FontWeight.bold)
                          ),
                          TextSpan(
                            text: " and ",
                          ),
                          TextSpan(
                              text: AppStrings.privacy,
                              style: TextStyle(color: Colors.black , fontSize: 17 , fontWeight: FontWeight.bold)
                          ),
                        ]
                    )),
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
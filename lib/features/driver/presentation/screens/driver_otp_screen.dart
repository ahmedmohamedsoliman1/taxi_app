import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/config/user_provider.dart';
import 'package:taxi_app/features/authontication/data/user_model.dart';
import 'package:taxi_app/features/authontication/presentation/screens/login_screen.dart';
import 'package:taxi_app/features/profile_settings/presentation/screens/profile_screen.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../authontication/presentation/widgets/back_ground_widget.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import 'driver_input_profile_screen.dart';
import 'driver_login_screen.dart';

class DriverOTPScreen extends StatefulWidget{

  static const String routeName = "driver_otp";

  @override
  State<DriverOTPScreen> createState() => _DriverOTPScreenState();
}

class _DriverOTPScreenState extends State<DriverOTPScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String code = "" ;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map ;
    var provider = Provider.of<UserProvider>(context);
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    BackGroundWidget(),
                    Positioned(
                      top: 50,
                      left: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back , color: AppColors.primaryColor,)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: textWidget(text: AppStrings.phone_verify),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                  child: textWidget(text: AppStrings.enter_otp , fontSize: 22 , fontWeight:  FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Pinput(
                  length: 6,
                  onChanged: (value){
                    code = value ;
                  },
                  defaultPinTheme: defaultPinTheme,
                  validator: (s) {
                    return s == code ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: () async{
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: DriverLoginScreen.verify,
                          smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      String userId = FirebaseAuth.instance.currentUser.uid;
                      UserModel userModer = UserModel(id:  userId , phone: args["phone"] , isAdriver: true);
                      var userObject =  await FireBaseFuns.saveUser(userModer);
                      Navigator.pushReplacementNamed(context, DriverProfileScreen.routeName);
                      var getUserData = await FireBaseFuns.getUser(userId);
                      provider.user = getUserData ;
                    }catch (e){
                      print("Wrong otp");
                    }
                  }, child: Text("Verify phone number" , style: TextStyle(fontSize: 18),) ,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor , shape: StadiumBorder()),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 17, color: Colors.black),
                          children: [
                            TextSpan(
                              text: AppStrings.resend_code + " ",
                            ),
                            TextSpan(
                                text: AppStrings.ten_seconds,
                                style: TextStyle(color: Colors.black , fontSize: 17 , fontWeight: FontWeight.bold)
                            ),
                          ]
                      )),
                ) ,
              ],
            ),
          ),
        ));
  }
}
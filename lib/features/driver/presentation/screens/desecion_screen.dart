import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/features/authontication/presentation/widgets/text_widget.dart';
import '../../../authontication/presentation/screens/login_screen.dart';
import '../../../authontication/presentation/widgets/back_ground_widget.dart';
import '../../../driver_rejestration/presentation/screens/complete_registration_one.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../widgets/elevated_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/config/user_provider.dart';

import 'driver_input_profile_screen.dart';
import 'driver_login_screen.dart';

class DesecionScreen extends StatelessWidget{

  static const String routeName = "desecion" ;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView (
        child: Column (
          children: [
            BackGroundWidget() ,
            SizedBox(height: 20,),
            textWidget(text: "Welcome !" , color: Colors.black , fontWeight: FontWeight.bold , fontSize: 22),
            SizedBox(height: 30,),
            ElevatedButtonWidget ((){
              print("driver");
              provider.firebaseUser != null && provider.user.isAdriver == true ?
             Navigator.pushReplacementNamed(context, CompleteDreinerRegisterationOne.routeName) :
             Navigator.pushReplacementNamed(context, DriverLoginScreen.routeName);
            } , context , "Login as a driver" , Icons.drive_eta),
            SizedBox(height: 15,),
            ElevatedButtonWidget ((){
              print ("user");
                provider.firebaseUser != null && provider.user.isAdriver == false ? Navigator.pushReplacementNamed(context, HomeScreen.routeName) :
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            } , context , "Login as a user" ,  Icons.person ),
          ],
        ),
      ),
    );
  }
}
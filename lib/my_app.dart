import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/config/app_theming.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/config/user_provider.dart';
import 'package:taxi_app/features/authontication/presentation/screens/login_screen.dart';
import 'package:taxi_app/features/authontication/presentation/screens/otp_screen.dart';

import 'features/home/presentation/screens/home_screen.dart';
import 'features/profile_settings/presentation/screens/get_data_fireBase_screen.dart';
import 'features/profile_settings/presentation/screens/profile_screen.dart';
import 'features/profile_settings/presentation/screens/profile_screen_data.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null ? HomeScreen.routeName : LoginScreen.routeName,
      routes: {
        LoginScreen.routeName : (context) => LoginScreen(),
        OTPScreen.routeName : (context) => OTPScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        ProfileScreen.routeName :(context) => ProfileScreen(),
        ProfileDataScreen.routeName :(context) => ProfileDataScreen(),
        GetDataFromFire.routeName : (context) => GetDataFromFire(),
      },
      locale: Locale ("en"),
      theme: AppTheming.lightTheme,
    );
  }
}
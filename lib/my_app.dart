import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/config/app_theming.dart';
import 'package:taxi_app/config/user_provider.dart';
import 'package:taxi_app/features/authontication/presentation/screens/login_screen.dart';
import 'package:taxi_app/features/authontication/presentation/screens/otp_screen.dart';
import 'features/driver/presentation/screens/desecion_screen.dart';
import 'features/driver/presentation/screens/driver_input_profile_screen.dart';
import 'features/driver/presentation/screens/driver_login_screen.dart';
import 'features/driver/presentation/screens/driver_otp_screen.dart';
import 'features/driver/presentation/screens/driver_output_profile_screen.dart';
import 'features/driver/presentation/widgets/driver_data_widget.dart';
import 'features/driver_rejestration/presentation/screens/complete_registration_one.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/payment/presentation/screens/add_new_card_screen.dart';
import 'features/payment/presentation/screens/payment_cards_screen.dart';
import 'features/profile_settings/presentation/screens/get_data_fireBase_screen.dart';
import 'features/profile_settings/presentation/screens/profile_screen.dart';
import 'features/profile_settings/presentation/screens/profile_screen_data.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: DesecionScreen.routeName,
      routes: {
        LoginScreen.routeName : (context) => LoginScreen(),
        OTPScreen.routeName : (context) => OTPScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        ProfileScreen.routeName :(context) => ProfileScreen(),
        ProfileDataScreen.routeName :(context) => ProfileDataScreen(),
        GetDataFromFire.routeName : (context) => GetDataFromFire(),
        PaymentCardsScreen.routeName : (context) => PaymentCardsScreen(),
        AddNewCardScreen.routeName : (context) => AddNewCardScreen (),
        DesecionScreen.routeName : (context) => DesecionScreen(),
        DriverLoginScreen.routeName : (context) => DriverLoginScreen(),
        DriverOTPScreen.routeName : (context) => DriverOTPScreen(),
        DriverProfileScreen.routeName : (context) => DriverProfileScreen(),
        DriverProfileDataScreen.routeName : (context) => DriverProfileDataScreen(),
        GetDriverDataFromFire.routeName : (context) => GetDriverDataFromFire(),
        CompleteDreinerRegisterationOne.routeName :(context) => CompleteDreinerRegisterationOne(),
      },
      locale: Locale ("en"),
      theme: AppTheming.lightTheme,
    );
  }
}
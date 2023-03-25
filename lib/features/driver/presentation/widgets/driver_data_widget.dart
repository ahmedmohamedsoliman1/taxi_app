import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/features/profile_settings/data/models/profile_model.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import '../screens/driver_output_profile_screen.dart';

class GetDriverDataFromFire extends StatefulWidget{
  static const String routeName = "get_driver_data" ;
  @override
  State<GetDriverDataFromFire> createState() => _GetDriverDataFromFireState();
}

class _GetDriverDataFromFireState extends State<GetDriverDataFromFire> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <ProfileModel> (
      future: FireBaseFuns.getProfileDataFromFireBase(),
      builder: (context , asyncSnapShot){
        if (asyncSnapShot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if (asyncSnapShot.hasError){
          return Column(
            children: [
              Icon(Icons.wifi_off_sharp , color: Colors.black, size: 40,) ,
              SizedBox(height: 10,),
              textWidget(text: "Something is wrong ")
            ],
          );
        }else {
          /// data
          var data = asyncSnapShot.data ;
          print(data);
          return DriverProfileDataScreen (
            image: data.image ?? "",
            home: data.homeAddress ?? "",
            name: data.name ?? "",
            business: data.businessAddress ?? "",
            shopping: data.shoppingCenter ?? "",
          );
        }
      },
    );
  }
}
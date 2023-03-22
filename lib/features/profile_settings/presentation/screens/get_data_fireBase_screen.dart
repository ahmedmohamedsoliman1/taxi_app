import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/features/profile_settings/data/models/profile_model.dart';
import 'package:taxi_app/features/profile_settings/presentation/screens/profile_screen_data.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';

class GetDataFromFire extends StatefulWidget{
  static const String routeName = "get_data" ;
  @override
  State<GetDataFromFire> createState() => _GetDataFromFireState();
}

class _GetDataFromFireState extends State<GetDataFromFire> {

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
          return ProfileDataScreen (
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
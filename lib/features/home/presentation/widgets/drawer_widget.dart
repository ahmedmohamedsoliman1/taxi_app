import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/features/profile_settings/presentation/screens/get_data_fireBase_screen.dart';

import '../../../profile_settings/data/models/profile_model.dart';
import '../../../profile_settings/presentation/screens/profile_screen.dart';
import 'custom_text_widget.dart';

class DrawerWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 30),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<ProfileModel>(
            future: FireBaseFuns.getProfileDataFromFireBase(),
              builder: (context , asynSnapShot){
               if (asynSnapShot.connectionState == ConnectionState.waiting){
                 return Center(child: CircularProgressIndicator(),);
               }else if (asynSnapShot.hasError){
                 return Column(
                   children: [
                     Icon(Icons.wifi_off_sharp , color: Colors.black,),
                     SizedBox(height: 5,),
                     Text("Somthing went wrong")
                   ],
                 );
               } else {
                 /// data
                 var data = asynSnapShot.data ;
                 return InkWell(
                   onTap: (){
                     Navigator.pop (context);
                     data.name == null ? Navigator.pushNamed(context, ProfileScreen.routeName) :
                     Navigator.pushNamed(context, GetDataFromFire.routeName);
                   },
                   child: Row(
                     children: [
                       Container(
                         width: 50,
                         height: 50,
                         clipBehavior: Clip.antiAlias,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle ,
                         ),
                         child: Image (image: NetworkImage(data.image ?? ""),
                           fit: BoxFit.fill,width: double.infinity, height: double.infinity,),
                       ),
                       SizedBox(width: 10,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           RichText(
                               text: TextSpan(
                                   children: [
                                     TextSpan(
                                         text: "Good morninig \n" ,
                                         style: TextStyle(color: Colors.black , fontSize: 15)
                                     ),
                                     TextSpan(
                                         text: data.name ?? "" ,
                                         style: TextStyle(color: Colors.green[600] , fontSize: 20 , fontWeight: FontWeight.bold)
                                     ),
                                   ]
                               )),
                         ],
                       )
                     ],
                   ),
                 );
               }
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Divider(thickness: 0.5 , color: Colors.black,) ,
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Payment History" ,
          onPressed: (){
            Navigator.pop(context);
          }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Ride History" ,
              onPressed: (){
                Navigator.pop(context);
              } , isVisible: true),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Invite Friends" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Promo Codes" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Settings" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Support" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20 ,text: "Log Out" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          Spacer(),
          Divider(color: Colors.black, thickness: 0.5,),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.w200 , fontSize: 15 ,text: "Do more" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.w200 , fontSize: 15 ,text: "Get Food Delivery" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.w200 , fontSize: 15 ,text: "Make Money Driving" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          customTextWidget (color: Colors.black , fontWeight: FontWeight.w200 , fontSize: 15 ,text: "Rate us on Store" ,
              onPressed: (){
                Navigator.pop(context);
              }),
          Spacer()
        ],
      ),
    );
  }

}
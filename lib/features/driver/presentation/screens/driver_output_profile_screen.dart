import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/features/home/presentation/screens/home_screen.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import '../../../driver_rejestration/presentation/screens/complete_registration_one.dart';
import '../../../profile_settings/presentation/widgets/container_widget.dart';
import '../widgets/driver_bottom_sheet.dart';


class DriverProfileDataScreen extends StatefulWidget{
  static const String routeName = "driver_profile_data";
  String name ;
  String home ;
  String shopping ;
  String image ;
  String business ;
  DriverProfileDataScreen ({this.name , this.image , this.home , this.business , this.shopping});

  @override
  State<DriverProfileDataScreen> createState() => _DriverProfileDataScreenState();
}

class _DriverProfileDataScreenState extends State<DriverProfileDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Background.png"),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 100),
                        child: Text(AppStrings.profile_screen,
                          style: TextStyle(color: Colors.white, fontSize: 23,
                              fontWeight: FontWeight.bold),),
                      ),
                    )
                ),
                Container(
                    clipBehavior: Clip.antiAlias,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle
                    ),
                    child: Image(image: NetworkImage(widget.image),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,)
                ),
              ],
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: textWidget(
                  text: "Name", fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            widget.name != null ? containerWidget(context, widget.name) : Text(
                ""),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: textWidget(text: "Email",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            widget.home != null ? containerWidget(context, widget.home) : Text(
                ""),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.02,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(onPressed: () {
                showSheet();
              },
                child: textWidget(
                    text: "Edit", color: Colors.white, fontSize: 20)
                ,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(onPressed: () {
                Navigator.pushReplacementNamed(context, CompleteDreinerRegisterationOne.routeName);
              },
                child: textWidget(
                    text: "Go to contiue registeration", color: Colors.white, fontSize: 20)
                ,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),),
            )
          ],
        ),
      ),
    );
  }

  void showSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => DriverBottomSheetWidget ());
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/features/home/presentation/screens/home_screen.dart';
import 'package:taxi_app/features/profile_settings/presentation/screens/profile_screen.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';
import '../widgets/bottom_sheet_widget.dart';
import '../widgets/container_widget.dart';

class ProfileDataScreen extends StatefulWidget{
  static const String routeName = "profile_data";
  String name ;
  String home ;
  String shopping ;
  String image ;
  String business ;
  ProfileDataScreen ({this.name , this.image , this.home , this.business , this.shopping});

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
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
              child: textWidget(text: "Home address",
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
                .height * 0.01,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: textWidget(text: "Business address",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            widget.business != null
                ? containerWidget(context, widget.business)
                : Text(""),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: textWidget(text: "Shopping center",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.01,),
                widget.shopping != null
                ? containerWidget(context, widget.shopping)
                : Text(""),
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
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
                child: textWidget(
                    text: "Go to home", color: Colors.white, fontSize: 20)
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
        context: context, builder: (context) => BottomSheetWidget ());
  }
}
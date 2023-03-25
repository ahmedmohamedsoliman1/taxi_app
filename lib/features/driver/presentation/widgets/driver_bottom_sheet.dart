import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/features/profile_settings/presentation/widgets/text_fiel_widget.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../authontication/presentation/widgets/text_widget.dart';

class DriverBottomSheetWidget extends StatefulWidget{

  @override
  State<DriverBottomSheetWidget> createState() => _DriverBottomSheetWidgetState();
}

class _DriverBottomSheetWidgetState extends State<DriverBottomSheetWidget> {
  String name ;

  String homeAddress ;

  String businessAddress ;

  String shoppingCenter ;

  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shoppingController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column (
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: textWidget(text: "Name" , fontSize: 18 , fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(hint: "Enter your name",
                  validator: (text){
                    if (text == null || text.trim().isEmpty){
                      return "Please name field is required" ;
                    }else {
                      return null ;
                    }
                  },
                  onChanged: (text){
                    name = text ;
                  },
                  controller: nameController,
                  icon: Icon (Icons.person , color: AppColors.primaryColor, ),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: textWidget(text: "Email" , fontSize: 18 , fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(hint: "Enter your Email",
                  validator: (text){
                    if (text == null || text.trim().isEmpty){
                      return "Please home address field is required" ;
                    }else {
                      return null ;
                    }
                  },
                  onChanged: (text){
                    homeAddress = text ;
                  },
                  controller: homeController,
                  icon: Icon (Icons.home , color: AppColors.primaryColor,),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              ElevatedButton(onPressed: ()async{
                if (formKey.currentState.validate() == true) {
                  await FireBaseFuns.updateProfileData(
                      name, homeAddress, businessAddress, shoppingCenter).then((value) => {
                    Navigator.pop(context),
                    print("Updated")
                  });
                }
              }, child: textWidget(text: AppStrings.update , color: Colors.white , fontSize: 20  )
                , style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),),
            ],
          ),
        ),
      ),
    );
  }
}
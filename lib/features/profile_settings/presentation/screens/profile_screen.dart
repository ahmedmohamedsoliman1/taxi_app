import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/core/app_colors.dart';
import 'package:taxi_app/features/authontication/presentation/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/fireBase_funs.dart';
import '../../../../core/app_strings.dart';
import '../../data/models/profile_model.dart';
import '../widgets/text_fiel_widget.dart';
import 'get_data_fireBase_screen.dart';

class ProfileScreen extends StatefulWidget{

  static const String routeName = "profile" ;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String text ;
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shoppingController = TextEditingController();
  String name ;
  String homeAddress ;
  String businessAddress ;
  String shoppingCenter ;
  ImagePicker picker = ImagePicker();
  XFile image ;
  var formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage (
                            image: AssetImage ("assets/images/Background.png") ,
                            fit: BoxFit.cover,
                        )
                    ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 100),
                          child: Text(AppStrings.profile_edit_screen , style: TextStyle(color: Colors.white , fontSize: 23 ,
                          fontWeight: FontWeight.bold),),
                        ),
                      )
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.2,
                    decoration: BoxDecoration (
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle
                    ),
                    child: InkWell(
                      onTap: ()async{
                        image = await picker.pickImage(source: ImageSource.gallery);
                        setState((){});
                      },
                        child: image == null ? Icon(Icons.camera_alt_outlined , color: Colors.black, size: 35,) :
                    Image.file(File(image.path) , fit: BoxFit.fill, width: double.infinity,
                    height: double.infinity,)),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
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
                child: textWidget(text: "Home address" , fontSize: 18 , fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(hint: "Enter your home address",
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
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: textWidget(text: "Business address" , fontSize: 18 , fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(hint: "Enter your business address",
                  validator: (text){
                    if (text == null || text.trim().isEmpty){
                      return "Please business address field is required" ;
                    }else {
                      return null ;
                    }
                  },
                  onChanged: (text){
                    businessAddress = text ;
                  },
                  controller: businessController,
                  icon: Icon (Icons.business_center_rounded , color: AppColors.primaryColor,),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: textWidget(text: "Shopping center" , fontSize: 18 , fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(hint: "shopping center",
                  validator: (text){
                  if (text == null || text.trim().isEmpty){
                    return "Please shopping center field is required" ;
                  }else {
                    return null ;
                  }
                  },
                  onChanged: (text){
                   shoppingCenter = text ;
                  },
                  controller: shoppingController,
                  icon: Icon (Icons.shopping_cart , color: AppColors.primaryColor,),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: ()async{
                   if (formKey.currentState.validate() == true && image != null){
                     isLoadingFun(true);
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(""
                         "Profile data saved please wait ....")));
                     await uploadImage(image.path);
                     ProfileModel profileModel = ProfileModel(
                       name: nameController.text ,
                       homeAddress: homeController.text ,
                       businessAddress: businessController.text ,
                       shoppingCenter: shoppingController.text ,
                       image:await uploadImage(image.path) ,
                     );
                     await FireBaseFuns.saveProfileDataInFireBase(profileModel).then((value) =>
                     {
                       Navigator.pushReplacementNamed(context, GetDataFromFire.routeName , arguments: {
                         "profile" : profileModel ,
                         "name" : profileModel.name ,
                         "shopping" : profileModel.shoppingCenter ,
                         "business" : profileModel.businessAddress ,
                         "home" : profileModel.homeAddress,
                         "image" : profileModel.image ,
                         "id" : profileModel.id
                       })
                     }
                     );
                   }else if (image == null){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please upload an image")));
                   }
                }, child: textWidget(text: "Submit" , color: Colors.white , fontSize: 20  )
                  , style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future <String> uploadImage (String image)async{
    final file = File(image);
    final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$image");
    final uploadImage = await firebaseStorageRef.putFile(file);
    print("done");
    var imageUrl = await FirebaseStorage.instance.ref().child("images/$image").getDownloadURL();
    print(imageUrl);
    return imageUrl ;
  }

  Widget isLoadingFun (bool isLoading){
    if (isLoading){
      return Center(child: CircularProgressIndicator(),);
    }
  }
}
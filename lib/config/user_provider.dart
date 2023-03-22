import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxi_app/config/fireBase_funs.dart';
import 'package:taxi_app/features/authontication/data/user_model.dart';

class UserProvider extends ChangeNotifier{

  UserModel user  ;

  User firebaseUser ;

  UserProvider (){
    firebaseUser = FirebaseAuth.instance.currentUser ;
    initUser();
  }

   void initUser ()async{
    if (firebaseUser != null){
      user = await  FireBaseFuns.getUser(firebaseUser.uid);
    }
  }
}
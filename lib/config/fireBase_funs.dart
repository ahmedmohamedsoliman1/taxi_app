import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/authontication/data/user_model.dart';
import '../features/profile_settings/data/models/profile_model.dart';

class FireBaseFuns{
 /// profile
  static CollectionReference<ProfileModel> getCollectionFromFirebase (){
    return FirebaseFirestore.instance.collection('profile').withConverter<ProfileModel>(
      fromFirestore: (snapshot, _) => ProfileModel.fromJson(snapshot.data()),
      toFirestore: (profile, _) => profile.toJson(),
    );
  }

  static Future <void> saveProfileDataInFireBase (ProfileModel profileModel){
    String uid = FirebaseAuth.instance.currentUser.uid ;
    return getCollectionFromFirebase().doc(uid).set(profileModel);
  }


  static Future<ProfileModel> getProfileDataFromFireBase ()async{
    String uid = FirebaseAuth.instance.currentUser.uid ;
    var documentSnapShot = await getCollectionFromFirebase().doc(uid).get();
    return documentSnapShot.data();
  }


  static Future<void> updateProfileData (String name , String home , String business , String shopping){
    String uid = FirebaseAuth.instance.currentUser.uid ;
    return getCollectionFromFirebase().doc(uid).update({
      "name" : name ,
      "home_address" : home ,
      "business_address" : business ,
      "shopping_address" : shopping,
    });
  }
 /// user
  static CollectionReference<UserModel> getUserCollectionFromFirebase (){
    return FirebaseFirestore.instance.collection('user').withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()),
      toFirestore: (user, _) => user.toJson(),
    );
  }

  static Future<void> saveUser (UserModel userModel){
    return getUserCollectionFromFirebase().doc(userModel.id).set(userModel);
  }

  static Future<UserModel> getUser (String userId)async{
    var documentSnapShot = await getUserCollectionFromFirebase().doc(userId).get();
    return documentSnapShot.data();
  }

}
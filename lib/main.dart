import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/user_provider.dart';
import 'my_app.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
      child: MyApp()));
}

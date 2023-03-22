import 'package:flutter/cupertino.dart';

class BackGroundWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background Mask.png"),
            fit: BoxFit.cover,
          )
      ),
      child: Center (
        child: Image (image: AssetImage("assets/images/green_taxi.png"),),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Validator = String Function(String);
typedef OnChanged = void Function(String);
class TextFieldWidget extends StatelessWidget{
  String hint ;
  Widget icon ;
  TextEditingController controller ;
  Validator validator ;
  OnChanged onChanged ;


  TextFieldWidget ({this.hint , this.icon , this.controller , this.validator , this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration (
        hintText: hint ,
        prefixIcon: icon,
        border: OutlineInputBorder ()
      ),
    );
  }
}
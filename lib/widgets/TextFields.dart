import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

loginTextField(
    {
  String validatorMsg,
  TextEditingController textEditingController,
  Key key,
  bool obscureText = false,
  String labelText,
      String validMsg,
  TextInputAction textInputAction,
    }
    ){
  return TextFormField(
    textInputAction: textInputAction,

    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0))
      ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red,width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0))
        ),
    ),
    textAlign: TextAlign.center,
    obscureText: obscureText ?? '',
    key: key,
    controller: textEditingController ?? null,
    style: TextStyle(
      color: Colors.black
    ),
    validator: (value){
      if(value.isEmpty){
        return validatorMsg;
      }
      return null;
    },
  );
}

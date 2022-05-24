import 'package:flutter/material.dart';

kTextDecoration({required String hint,Widget? suffixIcon}){
  return InputDecoration(
      labelText: hint,
      border: OutlineInputBorder(

      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      suffixIcon: suffixIcon,
      fillColor: Colors.white,
      filled: true,
  );
}
kUserTextDecoration({required String hint,Widget? suffixIcon}){
  return InputDecoration(
    labelText: hint,
    labelStyle: TextStyle(
      color: Colors.white
    ),
    border: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white
      )
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white
        )
    ),
    suffixIcon: suffixIcon,
    filled: true,
  );
}

kArtistFormTextDecoration({required String hint}){
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Color.fromRGBO(134, 146, 166, 1)),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromRGBO(134, 146, 166, 1)
        )
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromRGBO(134, 146, 166, 1)
        )
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/utils/StringUtils.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

class StyleUtils {
  InputDecoration textFieldDecoration(String hint, String lable) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(16),
      hintText: hint,
      labelText: lable,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
    );
  }

  TextStyle loginTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontFamily: StringUtils().fontRoboto,
        fontSize: 14);
  }

  TextStyle segmanetTextStyle() {
    return TextStyle(
        fontFamily: UtilsImporter().stringUtils.fontRoboto,
        color: Colors.black87,
        fontWeight: FontWeight.w700,
        fontSize: 16);
  }

  TextStyle homeTextStyle() {
    return TextStyle(
        color: Colors.black, fontFamily: StringUtils().fontLogin, fontSize: 28);
  }
}

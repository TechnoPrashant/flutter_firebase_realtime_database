import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

class WidgetUtils {
  Widget button(String buttonName) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: Colors.blue,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: UtilsImporter().stringUtils.fontRoboto),
            ),
          )),
    );
  }

  Widget spaceVertical(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget spacehorizontal(double width) {
    return SizedBox(
      width: width,
    );
  }

  Widget segmentViewText(String name) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: UtilsImporter().styleUtils.segmanetTextStyle(),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_login/model/ContactBean.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';
import 'package:flutter_firebase_login/utils/StringUtils.dart' as Const;

class FirebaseAuthUtils {
  final notesReference =
      FirebaseDatabase.instance.reference().child('mycontact');

  void addContact(ContactBean covariant) {
    notesReference.push().set({
      Const.StringUtils.KEY_NAME: covariant.fullname,
      Const.StringUtils.KEY_NUMBER: covariant.phoneNumber,
      Const.StringUtils.KEY_EMAIL: covariant.emailAddress,
      Const.StringUtils.KEY_ISFAV: covariant.isfav
    }).catchError(((error) {}));
  }
}

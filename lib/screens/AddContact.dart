import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/model/ContactBean.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

TextEditingController _textEditingControllerName = new TextEditingController();
TextEditingController _textEditingControllerEmail = new TextEditingController();
TextEditingController _textEditingControllerMobile =
    new TextEditingController();

class AddContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(UtilsImporter().stringUtils.lableCreateAccount,
            style: TextStyle(
              color: Colors.blue,
              fontFamily: UtilsImporter().stringUtils.fontLogin,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            )),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.done,
                size: 30,
                color: Colors.blue,
              ),
              onPressed: () {
                _addContact(context);
              })
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: AddContactScreen(),
    );
  }
}

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  double cardElevation = 8;
  bool isLoginSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: <Widget>[
          UtilsImporter().widgetUtils.spaceVertical(20),
          Image.asset(
            'images/logofb.png',
            height: 160,
            fit: BoxFit.fitHeight,
          ),
          TextField(
            controller: _textEditingControllerName,
            maxLines: 1,
            style: UtilsImporter().styleUtils.loginTextFieldStyle(),
            decoration: UtilsImporter().styleUtils.textFieldDecoration(
                UtilsImporter().stringUtils.hintName,
                UtilsImporter().stringUtils.lableFullname),
          ),
          UtilsImporter().widgetUtils.spaceVertical(10),
          TextField(
            controller: _textEditingControllerMobile,
            keyboardType: TextInputType.number,
            maxLines: 1,
            style: UtilsImporter().styleUtils.loginTextFieldStyle(),
            decoration: UtilsImporter().styleUtils.textFieldDecoration(
                UtilsImporter().stringUtils.hintNumber,
                UtilsImporter().stringUtils.lableMobile),
          ),
          UtilsImporter().widgetUtils.spaceVertical(10),
          TextField(
            controller: _textEditingControllerEmail,
            maxLines: 1,
            style: UtilsImporter().styleUtils.loginTextFieldStyle(),
            decoration: UtilsImporter().styleUtils.textFieldDecoration(
                UtilsImporter().stringUtils.hintEmail,
                UtilsImporter().stringUtils.labelEmail),
          ),
        ],
      ),
    );
  }
}

void _addContact(BuildContext context) {
  if (!UtilsImporter()
      .commanUtils
      .validateName(_textEditingControllerName.text)) {
    UtilsImporter()
        .commanUtils
        .showToast(UtilsImporter().stringUtils.retrunName, context);
  } else if (!UtilsImporter()
      .commanUtils
      .validateMobile(_textEditingControllerMobile.text)) {
    UtilsImporter()
        .commanUtils
        .showToast(UtilsImporter().stringUtils.retrunNumber, context);
  } else if (!UtilsImporter()
      .commanUtils
      .validateEmail(_textEditingControllerEmail.text)) {
    UtilsImporter()
        .commanUtils
        .showToast(UtilsImporter().stringUtils.retrunEmail, context);
  } else {
    ContactBean contactBean = new ContactBean(
        _textEditingControllerName.text,
        _textEditingControllerEmail.text,
        _textEditingControllerMobile.text,
        false);
    _textEditingControllerMobile.text = '';
    _textEditingControllerEmail.text = '';
    _textEditingControllerName.text = '';
    UtilsImporter()
        .commanUtils
        .showToast(UtilsImporter().stringUtils.messageSuccess, context);
    UtilsImporter().firebaseAuthUtils.addContact(contactBean);
  }
}

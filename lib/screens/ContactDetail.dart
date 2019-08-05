import 'package:avataaar_image/avataaar_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';
import 'package:flutter_firebase_login/model/GetContactBean.dart';
import 'package:flutter_firebase_login/utils/StringUtils.dart' as Const;

final notesReference = FirebaseDatabase.instance.reference().child('mycontact');
TextEditingController _textEditingControllerName = new TextEditingController();
TextEditingController _textEditingControllerEmail = new TextEditingController();
TextEditingController _textEditingControllerMobile =
    new TextEditingController();
GetContactBean _getContactBeanMain;

class ContactDetail extends StatelessWidget {
  GetContactBean _getContactBean;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
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
      body: ContactDetailScreen(this._getContactBean),
    );
  }

  ContactDetail(this._getContactBean);
}

class ContactDetailScreen extends StatefulWidget {
  GetContactBean _getContactBean;

  @override
  _ContactDetailScreenState createState() =>
      _ContactDetailScreenState(this._getContactBean);

  ContactDetailScreen(this._getContactBean);
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  GetContactBean _getContactBean;
  bool isFav;

  _ContactDetailScreenState(this._getContactBean);

  bool isEditVisible = false;
  bool isDetailsVisible = true;
  String fullname;

  @override
  void initState() {
    _textEditingControllerName.text = _getContactBean.fullname;
    _textEditingControllerEmail.text = _getContactBean.emailAddress;
    _textEditingControllerMobile.text = _getContactBean.phoneNumber;
    isFav = _getContactBean.isfav;
    _getContactBeanMain = _getContactBean;
    fullname = _getContactBeanMain.fullname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[detailsContact(), editContact()],
    ));
  }

  Widget detailsContact() {
    return Visibility(
      visible: isDetailsVisible,
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: AvataaarImage(
                avatar: Avataaar.random(),
                errorImage: Icon(
                  Icons.error,
                  color: Colors.grey,
                  size: 100,
                ),
                placeholder: CircularProgressIndicator(),
                width: 120.0,
              ),
            ),
            UtilsImporter().widgetUtils.spaceVertical(20),
            Text(
              fullname,
              style: UtilsImporter().styleUtils.homeTextStyle(),
            ),
            UtilsImporter().widgetUtils.spaceVertical(60),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                      size: 40,
                    ),
                    onPressed: null),
                UtilsImporter().widgetUtils.spacehorizontal(30),
                IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: null),
                UtilsImporter().widgetUtils.spacehorizontal(30),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black87,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        isEditVisible = true;
                        isDetailsVisible = false;
                        _textEditingControllerName.text =
                            _getContactBean.fullname;
                        _textEditingControllerEmail.text =
                            _getContactBean.emailAddress;
                        _textEditingControllerMobile.text =
                            _getContactBean.phoneNumber;
                        isFav = _getContactBean.isfav;
                        _getContactBeanMain = _getContactBean;
                      });
                    }),
                UtilsImporter().widgetUtils.spacehorizontal(30),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {
                      deleteData(_getContactBean.keyID, context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget editContact() {
    return Visibility(
      visible: isEditVisible,
      child: Container(
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
            UtilsImporter().widgetUtils.spaceVertical(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: UtilsImporter().widgetUtils.button('Update'),
                  onTap: () {
                    _UpdateContact(context);
                  },
                ),
                UtilsImporter().widgetUtils.spacehorizontal(40),
                GestureDetector(
                  child: UtilsImporter().widgetUtils.button('Cancel'),
                  onTap: () {
                    setState(() {
                      isEditVisible = false;
                      isDetailsVisible = true;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _UpdateContact(BuildContext context) {
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
      UtilsImporter()
          .commanUtils
          .showToast(UtilsImporter().stringUtils.updateMessageSuccess, context);
      notesReference.child(_getContactBeanMain.keyID).set({
        Const.StringUtils.KEY_ISFAV: _getContactBeanMain.isfav,
        Const.StringUtils.KEY_NUMBER: _textEditingControllerMobile.text,
        Const.StringUtils.KEY_EMAIL: _textEditingControllerEmail.text,
        Const.StringUtils.KEY_NAME: _textEditingControllerName.text
      }).then((_) {
        setState(() {
          fullname = _textEditingControllerName.text;
          isEditVisible = false;
          isDetailsVisible = true;
        });
        _textEditingControllerMobile.text = '';
        _textEditingControllerEmail.text = '';
        _textEditingControllerName.text = '';
      });
    }
  }

  void deleteData(String key, BuildContext context) {
    notesReference.child(key).remove();
    UtilsImporter()
        .commanUtils
        .showToast(UtilsImporter().stringUtils.deleteMessageSuccess, context);
    Navigator.pop(context, true);
  }
}

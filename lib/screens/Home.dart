import 'package:avataaar_image/avataaar_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/model/GetContactBean.dart';
import 'package:flutter_firebase_login/screens/AddContact.dart';
import 'package:flutter_firebase_login/utils/StringUtils.dart' as Const;
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_firebase_login/screens/ContactDetail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelection = 0;
  bool isNewList = false;
  final notesReference =
      FirebaseDatabase.instance.reference().child('mycontact');
  List<GetContactBean> _contactList = [];
  bool isFav = false;

  Map<int, Widget> _children() => {
        0: UtilsImporter()
            .widgetUtils
            .segmentViewText(UtilsImporter().stringUtils.strSagmentCotnact),
        1: UtilsImporter()
            .widgetUtils
            .segmentViewText(UtilsImporter().stringUtils.strSgamentFav),
      };

  Icon _icon = new Icon(
    Icons.favorite,
    color: Colors.grey,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Firebase Real Time Database',
          style: UtilsImporter().styleUtils.segmanetTextStyle(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return AddContact();
          }));
          if (result) {
            getContactList();
          }
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: MaterialSegmentedControl(
                  children: _children(),
                  selectionIndex: _currentSelection,
                  borderColor: Colors.black,
                  selectedColor: Colors.blue,
                  unselectedColor: Colors.white,
                  onSegmentChosen: (index) {
                    setState(() {
                      _currentSelection = index;
                    });
                    getContactList();
                  },
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(20),
              Expanded(child: getSetCotnactList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSetCotnactList() {
    if (!isNewList) {
      return Container(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _contactList.length,
          itemBuilder: (BuildContext con, int index) {
            return GestureDetector(
              onTap: () async {
                bool result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return ContactDetail(_contactList[index]);
                }));
                if (result) {
                  getContactList();
                }
              },
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                child: ListTile(
                  leading: AvataaarImage(
                    avatar: Avataaar.random(),
                    errorImage: Icon(Icons.error),
                    placeholder: CircularProgressIndicator(),
                    width: 128.0,
                  ),
                  title: Text(
                    _contactList[index].fullname.substring(0, 1).toUpperCase() +
                        _contactList[index].fullname.substring(1),
                    maxLines: 1,
                    style: UtilsImporter().styleUtils.homeTextStyle(),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(_contactList[index].phoneNumber +
                        '\n' +
                        _contactList[index].emailAddress),
                  ),
                  trailing: IconButton(
                    icon: iconFav(_contactList[index].isfav),
                    onPressed: () {
                      setState(() {
                        if (_contactList[index].isfav) {
                          updateFav(false, _contactList[index]);
                        } else {
                          updateFav(true, _contactList[index]);
                        }
                      });
                    },
                  ),
                ),
              ),
            );
          });
    }
  }

  Widget iconFav(bool isfav) {
    if (isfav) {
      isfav = false;
      return _icon = new Icon(
        Icons.favorite,
        color: Colors.green,
      );
    } else {
      isfav = true;
      return _icon = new Icon(
        Icons.favorite,
        color: Colors.grey,
      );
    }
  }

  void getContactList() {
    if (_contactList.length > 0) _contactList.clear();
    notesReference.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      setState(() {
        for (var key in keys) {
          GetContactBean contactBean = new GetContactBean(
            data[key][Const.StringUtils.KEY_NAME],
            data[key][Const.StringUtils.KEY_EMAIL],
            data[key][Const.StringUtils.KEY_NUMBER],
            data[key][Const.StringUtils.KEY_ISFAV],
            key,
          );
          if (_currentSelection == 0) {
            _contactList.add(contactBean);
          } else {
            if (contactBean.isfav == true) {
              _contactList.add(contactBean);
            }
          }
        }
        isNewList = true;
      });
    });
  }

  void updateFav(bool isFav, GetContactBean bean) {
    notesReference.child(bean.keyID).set({
      Const.StringUtils.KEY_ISFAV: isFav,
      Const.StringUtils.KEY_NUMBER: bean.phoneNumber,
      Const.StringUtils.KEY_EMAIL: bean.emailAddress,
      Const.StringUtils.KEY_NAME: bean.fullname
    }).then((_) {
      getContactList();
    });
  }
}

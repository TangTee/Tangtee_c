
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../HomePage.dart';
import '../utils/color.dart';
import 'package:tangteevs/widgets/custom_textfield.dart';

void showModalBottomSheetT(BuildContext context, t_id) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _report = FirebaseFirestore.instance
      .collection('report')
      .doc('reportPost')
      .collection(t_id['uid'])
      .doc();
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: Center(
                  child: Text(
                    'อนาจาร',
                    style: TextStyle(fontFamily: 'MyCustomFont', fontSize: 20),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': t_id['postid'],
                    'activityName': t_id['activityName'],
                    'place': t_id['place'],
                    'location': t_id['location'],
                    'date': t_id['date'],
                    'time': t_id['time'],
                    'detail': t_id['detail'],
                    'peopleLimit': t_id['peopleLimit'],
                    'uid': t_id['uid'],
                    'problem': 'อนาจาร',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                    child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: redColor,
                      fontFamily: 'MyCustomFont',
                      fontSize: 20),
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showModalBottomSheetRC(BuildContext context, r_pid, Map mytext) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _report = FirebaseFirestore.instance
      .collection('report')
      .doc('reportComment')
      .collection(mytext['uid'])
      .doc();
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: Center(
                  child: Text(
                    'อนาจาร',
                    style: TextStyle(fontFamily: 'MyCustomFont', fontSize: 20),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': mytext['postid'],
                    'Displayname': mytext['Displayname'],
                    'cid': mytext['cid'],
                    'comment': mytext['comment'],
                    'uid': mytext['uid'],
                    'problem': 'อนาจาร',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                  child: Text(
                    'ความรุนแรง',
                    style: TextStyle(
                      fontFamily: 'MyCustomFont',
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': mytext['postid'],
                    'Displayname': mytext['Displayname'],
                    'cid': mytext['cid'],
                    'comment': mytext['comment'],
                    'uid': mytext['uid'],
                    'problem': 'ความรุนแรง',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                  child: Text(
                    'การคุกคาม',
                    style: TextStyle(
                      fontFamily: 'MyCustomFont',
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': mytext['postid'],
                    'Displayname': mytext['Displayname'],
                    'cid': mytext['cid'],
                    'comment': mytext['comment'],
                    'uid': mytext['uid'],
                    'problem': 'การคุกคาม',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                  child: Text(
                    'ข้อมูลเท็จ',
                    style: TextStyle(
                      fontFamily: 'MyCustomFont',
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': mytext['postid'],
                    'Displayname': mytext['Displayname'],
                    'cid': mytext['cid'],
                    'comment': mytext['comment'],
                    'uid': mytext['uid'],
                    'problem': 'ข้อมูลเท็จ',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                  child: Text(
                    'สแปม',
                    style: TextStyle(
                      fontFamily: 'MyCustomFont',
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': mytext['postid'],
                    'Displayname': mytext['Displayname'],
                    'cid': mytext['cid'],
                    'comment': mytext['comment'],
                    'uid': mytext['uid'],
                    'problem': 'สแปม',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                  child: Text(
                    'คำพูดแสดงความเกลีดชัง',
                    style: TextStyle(
                      fontFamily: 'MyCustomFont',
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  _report.set({
                    'rid': _report.id,
                    'postid': mytext['postid'],
                    'Displayname': mytext['Displayname'],
                    'cid': mytext['cid'],
                    'comment': mytext['comment'],
                    'uid': mytext['uid'],
                    'problem': 'คำพูดแสดงความเกลีดชัง',
                    //'likes': [],
                    'timeStamp': DateTime.now(),
                    'reportBy': FirebaseAuth.instance.currentUser?.uid,
                  }).whenComplete(() {
                    nextScreenReplaceOut(context, MyHomePage());
                  });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                title: const Center(
                    child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: redColor,
                      fontFamily: 'MyCustomFont',
                      fontSize: 20),
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

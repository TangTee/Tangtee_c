import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../HomePage.dart';
import '../utils/color.dart';
import 'package:tangteevs/widgets/custom_textfield.dart';

void showModalBottomSheetRP(BuildContext context, r_pid) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _report =
      FirebaseFirestore.instance.collection('report').doc(r_pid['rid']);
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
                    'postid': r_pid['postid'],
                    'activityName': r_pid['activityName'],
                    'place': r_pid['place'],
                    'location': r_pid['location'],
                    'date': r_pid['date'],
                    'time': r_pid['time'],
                    'detail': r_pid['detail'],
                    'peopleLimit': r_pid['peopleLimit'],
                    'uid': r_pid['uid'],
                    'problem': 'อนาจาร',
                    'type': 'post',
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
                    'postid': r_pid['postid'],
                    'activityName': r_pid['activityName'],
                    'place': r_pid['place'],
                    'location': r_pid['location'],
                    'date': r_pid['date'],
                    'time': r_pid['time'],
                    'detail': r_pid['detail'],
                    'peopleLimit': r_pid['peopleLimit'],
                    'uid': r_pid['uid'],
                    'problem': 'ความรุนแรง',
                    'type': 'post',
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
                    'postid': r_pid['postid'],
                    'activityName': r_pid['activityName'],
                    'place': r_pid['place'],
                    'location': r_pid['location'],
                    'date': r_pid['date'],
                    'time': r_pid['time'],
                    'detail': r_pid['detail'],
                    'peopleLimit': r_pid['peopleLimit'],
                    'uid': r_pid['uid'],
                    'problem': 'การคุกคาม',
                    'type': 'post',
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
                    'postid': r_pid['postid'],
                    'activityName': r_pid['activityName'],
                    'place': r_pid['place'],
                    'location': r_pid['location'],
                    'date': r_pid['date'],
                    'time': r_pid['time'],
                    'detail': r_pid['detail'],
                    'peopleLimit': r_pid['peopleLimit'],
                    'uid': r_pid['uid'],
                    'problem': 'ข้อมูลเท็จ',
                    'type': 'post',
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
                    'postid': r_pid['postid'],
                    'activityName': r_pid['activityName'],
                    'place': r_pid['place'],
                    'location': r_pid['location'],
                    'date': r_pid['date'],
                    'time': r_pid['time'],
                    'detail': r_pid['detail'],
                    'peopleLimit': r_pid['peopleLimit'],
                    'uid': r_pid['uid'],
                    'problem': 'สแปม',
                    'type': 'post',
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
                    'postid': r_pid['postid'],
                    'activityName': r_pid['activityName'],
                    'place': r_pid['place'],
                    'location': r_pid['location'],
                    'date': r_pid['date'],
                    'time': r_pid['time'],
                    'detail': r_pid['detail'],
                    'peopleLimit': r_pid['peopleLimit'],
                    'uid': r_pid['uid'],
                    'problem': 'คำพูดแสดงความเกลีดชัง',
                    'type': 'post',
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

void showModalBottomSheetRC(BuildContext context, r_pid, Map mytext) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _report =
      FirebaseFirestore.instance.collection('report').doc(mytext['cid']);

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
                    'type': 'comment',
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
                    'type': 'comment',
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
                    'type': 'comment',
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
                    'type': 'comment',
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
                    'type': 'comment',
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
                    'type': 'comment',
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

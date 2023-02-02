import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/color.dart';

showModalBottomSheetC(BuildContext context) {
  final CollectionReference _categorys =
      FirebaseFirestore.instance.collection('categorys');
  var value = new Map();

  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.5,
        child: StreamBuilder(
          stream: _categorys.snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: new EdgeInsets.only(top: 10.0),
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];

                  var Mytext = new Map();
                  Mytext['Category'] = documentSnapshot['Category'];
                  Mytext['categoryId'] = documentSnapshot['categoryId'];
                  Mytext['color'] = documentSnapshot['color'];

                  return Card(
                    color: HexColor(Mytext['color']),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                      side: const BorderSide(
                        color: transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          textColor: mobileSearchColor,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          title: Center(
                              child: Text(Mytext['Category'],
                                  style: TextStyle(
                                      fontFamily: 'MyCustomFont',
                                      fontSize: 20))),
                          onTap: () {
                            value = showModalBottomSheetT(
                                context, Mytext['categoryId'], value);
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return const Text('helo');
          }),
        ),
      );
    },
  );
  return value;
}

showModalBottomSheetT(BuildContext context, categoryId, value) {
  final CollectionReference _tags =
      FirebaseFirestore.instance.collection('tags');

  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: StreamBuilder(
          stream: _tags.where("categoryId", isEqualTo: categoryId).snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  child: Expanded(
                    child: ListView.builder(
                      padding: new EdgeInsets.only(top: 10.0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                        var Mytext = new Map();
                        Mytext['tag'] = documentSnapshot['tag'];
                        Mytext['tagColor'] = documentSnapshot['tagColor'];

                        return Wrap(direction: Axis.horizontal, children: <
                            Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.27,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Column(children: [
                                SizedBox(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      value['_tag2'] = Mytext['tag'].toString();
                                      value['_tag2Color'] =
                                          Mytext['tagColor'].toString();
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    },
                                    child: Text(
                                      Mytext['tag'],
                                      style: const TextStyle(
                                          color: mobileSearchColor,
                                          fontSize: 14),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        side: BorderSide(
                                            color: HexColor(
                                              Mytext['tagColor'],
                                            ),
                                            width: 1.5)),
                                  ),
                                ),
                              ])),
                        ]);
                      },
                    ),
                  ),
                ),
              );
            }
            return const Text('helo');
          }),
        ),
      );
    },
  );
  return value;
}

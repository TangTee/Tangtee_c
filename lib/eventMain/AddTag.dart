// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:tangteevs/utils/color.dart';

// void showModalBottomSheetC(BuildContext context, tag) {
//   final CollectionReference _categorys =
//       FirebaseFirestore.instance.collection('categorys');

//   showModalBottomSheet(
//     useRootNavigator: true,
//     context: context,
//     builder: (BuildContext context) {
//       return StreamBuilder(
//         stream: _categorys.snapshots(),
//         builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: (snapshot.data! as dynamic).docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     snapshot.data!.docs[index];

//                 var Mytext = new Map();
//                 Mytext['Category'] = documentSnapshot['Category'];
//                 Mytext['categoryId'] = documentSnapshot['categoryId'];
//                 Mytext['color'] = documentSnapshot['color'];

//                 return Card(
//                   child: Column(
//                     children: [
//                       ListTile(
//                         tileColor: HexColor(Mytext['color']),
//                         textColor: white,
//                         contentPadding:
//                             const EdgeInsets.symmetric(vertical: 8.0),
//                         title: Center(
//                             child: Text(Mytext['Category'],
//                                 style: TextStyle(
//                                     fontFamily: 'MyCustomFont', fontSize: 20))),
//                         onTap: () {
//                           showModalBottomSheetT(context, Mytext['categoryId']);
//                         },
//                       )
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return const Text('helo');
//         }),
//       );
//     },
//   );
// }

// void showModalBottomSheetT(BuildContext context, categoryId) {
//   final CollectionReference _tags =
//       FirebaseFirestore.instance.collection('tags');

//   showModalBottomSheet(
//     useRootNavigator: true,
//     context: context,
//     builder: (BuildContext context) {
//       return StreamBuilder(
//         stream: _tags.where("categoryId", isEqualTo: categoryId).snapshots(),
//         builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: (snapshot.data! as dynamic).docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     snapshot.data!.docs[index];

//                 var Mytext = new Map();
//                 Mytext['tag'] = documentSnapshot['tag'];
//                 Mytext['tagColor'] = documentSnapshot['tagColor'];

//                 return Card(
//                   child: Column(
//                     children: [
//                       ListTile(
//                         tileColor: HexColor(Mytext['tagColor']),
//                         textColor: white,
//                         contentPadding:
//                             const EdgeInsets.symmetric(vertical: 8.0),
//                         title: Center(
//                             child: Text(
//                           Mytext['tag'],
//                           style: TextStyle(
//                               fontFamily: 'MyCustomFont', fontSize: 20),
//                         )),
//                         onTap: () {
//                           var tag = Mytext['tag'];
//                           Navigator.of(context)
//                               .popUntil((route) => route.isFirst);
//                         },
//                       )
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return const Text('helo');
//         }),
//       );
//     },
//   );
// }

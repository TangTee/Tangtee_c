// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:hexcolor/hexcolor.dart';

// import '../utils/color.dart';

// class TagButton extends StatefulWidget {
//   const TagButton({super.key});

//   @override
//   State<TagButton> createState() => _TagButtonState();
// }

// class _TagButtonState extends State<TagButton> {
//   final tagSet = FirebaseFirestore.instance.collection('tags');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<Object>(
//           stream: tagSet.snapshots(),
//           builder: (context, snapshot) {
//             final DocumentSnapshot documentSnapshot =
//                 snapshot.data!.docs[index];
//             var Mytext = new Map();
//             Mytext['tag'] = documentSnapshot['tag'];
//             Mytext['tagColor'] = documentSnapshot['tagColor'];
//             return OutlinedButton(
//               onPressed: () {},
//               child: Text(
//                 Mytext['tag'],
//                 style: const TextStyle(color: mobileSearchColor),
//               ),
//               style: OutlinedButton.styleFrom(
//                   side: BorderSide(
//                       color: HexColor(Mytext['tagColor']), width: 3)),
//             );
//           }),
//     );
//   }
// }

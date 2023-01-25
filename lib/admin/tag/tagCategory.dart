// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/color.dart';
import '../../utils/showSnackbar.dart';
import '../../widgets/custom_textfield.dart';

class TagCategory extends StatefulWidget {
  // final String categoryId; ต้องget data
  DocumentSnapshot categoryId;
  TagCategory({Key? key, required this.categoryId}) : super(key: key);

  @override
  _TagCategoryState createState() => _TagCategoryState();
}

class _TagCategoryState extends State<TagCategory> {
  var categoryData = {};
  var categoryNameData = {};
  var categoryColorData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  final CollectionReference _tags =
      FirebaseFirestore.instance.collection('tags');
  final TextEditingController _tagController = TextEditingController();
  final tagSet = FirebaseFirestore.instance.collection('tags');

  bool _isLoading = false;
  bool submit = false;
  final tagController = TextEditingController();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  controller: tagController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a comment';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 2, color: unselected),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(70)),
                      borderSide: BorderSide(width: 2, color: unselected),
                    ),
                    hintText: 'Add Tag here',
                    hintStyle: TextStyle(
                      color: unselected,
                      fontFamily: 'MyCustomFont',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    var tagSet2 = tagSet
                        .doc(widget.categoryId['categoryId'])
                        .collection('tags')
                        .doc();
                    await tagSet2.set({
                      'tagId': tagSet2.id,
                      'tag': tagController.text,
                      'tagColor': categoryData['color'].toString(),
                    }).whenComplete(() {
                      tagController.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: purple,
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 500,
            child: ListView(children: [
              StreamBuilder<QuerySnapshot>(
                stream: tagSet
                    .doc(widget.categoryId['categoryId'])
                    .collection('tags')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 500,
                      width: 600,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        snapshot.data!.docs[index];

                                    var Mytext = new Map();
                                    Mytext['tag'] = documentSnapshot['tag'];
                                    return Card(
                                      elevation: 2,
                                      child: ClipPath(
                                        child: Container(
                                          height: 80,
                                          child: ListTile(
                                            title: Text(Mytext['tag']),
                                            trailing: SingleChildScrollView(
                                              child: SizedBox(
                                                width: 160,
                                                child: Row(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                        '+',
                                                        style: TextStyle(
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'MyCustomFont',
                                                          color: unselected,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        onPressed: () {}),
                                                    IconButton(
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        onPressed:
                                                            () => showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Are you sure?'),
                                                                      content: Text(
                                                                          'This action cannot be undone.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          child:
                                                                              Text('Cancel'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              Text('OK'),
                                                                          onPressed:
                                                                              () {},
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3))),
                                      ),
                                      margin: const EdgeInsets.all(10),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _create(),
            child: Icon(Icons.add),
          ),
        ),
        // bottomNavigationBar: Container(
        //   color: white,
        //   child: Form(
        //     child: Row(
        //       children: [
        //         SizedBox(
        //           width: MediaQuery.of(context).size.width * 0.76,
        //           child: TextFormField(
        //             keyboardType: TextInputType.multiline,
        //             maxLines: 5,
        //             minLines: 1,
        //             controller: tagController,
        //             validator: (value) {
        //               if (value!.isEmpty) {
        //                 return 'Please enter a comment';
        //               }
        //               return null;
        //             },
        //             decoration: const InputDecoration(
        //               contentPadding:
        //                   EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        //               enabledBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(15)),
        //                 borderSide: BorderSide(width: 2, color: unselected),
        //               ),
        //               focusedBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(70)),
        //                 borderSide: BorderSide(width: 2, color: unselected),
        //               ),
        //               hintText: 'Add Tag here',
        //               hintStyle: TextStyle(
        //                 color: unselected,
        //                 fontFamily: 'MyCustomFont',
        //               ),
        //             ),
        //           ),
        //         ),
        //         IconButton(
        //           onPressed: () async {
        //             setState(() {
        //               _isLoading = true;
        //             });
        //             var tagSet2 = tagSet
        //                 .doc(categoryData['categoryId'])
        //                 .collection('tags')
        //                 .doc();
        //             await tagSet2.set({
        //               'tagId': tagSet2.id,
        //               'tag': tagController.text,
        //               'tagColor': categoryData['color'].toString(),
        //             }).whenComplete(() {
        //               tagController.clear();
        //             });
        //           },
        //           icon: const Icon(
        //             Icons.add,
        //             size: 30,
        //             color: purple,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}









//   @override
//   Widget build(BuildContext context) {
//     return DismissKeyboard(
//       child: MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             toolbarHeight: 50,
//             backgroundColor: mobileBackgroundColor,
//             leadingWidth: 130,
//             centerTitle: true,
//             leading: Container(
//               padding: const EdgeInsets.all(0),
//               child: Image.asset('assets/images/logo with name.png',
//                   fit: BoxFit.scaleDown),
//             ),
//           ),
//           body: ListView(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
//                     child: Text(
//                       categoryData['categoryId'].toString(),
//                       style: const TextStyle(
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: StreamBuilder<QuerySnapshot>(
//                       stream: tagSet
//                           .doc(categoryData['categoryId'])
//                           .collection('tags')
//                           .snapshots(),
//                       builder:
//                           (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (snapshot.hasData) {
//                           return Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: SizedBox(
//                                   child: ListView.builder(
//                                       itemCount: snapshot.data!.docs.length,
//                                       itemBuilder: (context, index) {
//                                         final DocumentSnapshot
//                                             documentSnapshot =
//                                             snapshot.data!.docs[index];

//                                         var categoryIdD =
//                                             categoryData['categoryId'];

//                                         var Mytext = new Map();
//                                         Mytext['tag'] = documentSnapshot['tag'];
//                                         Mytext['tagColor'] =
//                                             documentSnapshot['tagColor'];
//                                         return Card(
//                                           shape: RoundedRectangleBorder(
//                                             side: BorderSide(
//                                                 color: HexColor(
//                                                     categoryData['color']),
//                                                 width: 5),
//                                           ),
//                                           child: ClipPath(
//                                             child: Container(
//                                               // height: 80,
//                                               child: ListTile(
//                                                 title: Row(
//                                                   children: [
//                                                     Text(Mytext['tag']),
//                                                   ],
//                                                 ),
//                                                 trailing: SingleChildScrollView(
//                                                   child: SizedBox(
//                                                     // width: 160,
//                                                     child: Row(
//                                                       children: [
//                                                         IconButton(
//                                                             icon: const Icon(
//                                                                 Icons.edit),
//                                                             onPressed: () {}),
//                                                         IconButton(
//                                                             icon: const Icon(
//                                                                 Icons.edit),
//                                                             onPressed: () {}),
//                                                         IconButton(
//                                                             icon: const Icon(
//                                                                 Icons.edit),
//                                                             onPressed: () {}),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             clipper: ShapeBorderClipper(
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             3))),
//                                           ),
//                                           margin: const EdgeInsets.all(10),
//                                         );
//                                       }),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }

//                         return Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: const <Widget>[
//                               SizedBox(
//                                 height: 30.0,
//                                 width: 30.0,
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//           bottomNavigationBar: Container(
//             color: white,
//             child: Form(
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.76,
//                     child: TextFormField(
//                       keyboardType: TextInputType.multiline,
//                       maxLines: 5,
//                       minLines: 1,
//                       controller: tagController,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter a comment';
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(15)),
//                           borderSide: BorderSide(width: 2, color: unselected),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(70)),
//                           borderSide: BorderSide(width: 2, color: unselected),
//                         ),
//                         hintText: 'Add Tag here',
//                         hintStyle: TextStyle(
//                           color: unselected,
//                           fontFamily: 'MyCustomFont',
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () async {
//                       setState(() {
//                         _isLoading = true;
//                       });
//                       var tagSet2 = tagSet
//                           .doc(categoryData['categoryId'])
//                           .collection('tags')
//                           .doc();
//                       await tagSet2.set({
//                         'tagId': tagSet2.id,
//                         'tag': tagController.text,
//                         'tagColor': categoryData['color'].toString(),
//                       }).whenComplete(() {
//                         tagController.clear();
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.add,
//                       size: 30,
//                       color: purple,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

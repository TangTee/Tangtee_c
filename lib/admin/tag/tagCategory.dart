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

  final CollectionReference _tags =
      FirebaseFirestore.instance.collection('tags');

  Future<void> _delete(String tagId) async {
    await _tags.doc(tagId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a category')));
  }

  @override
  void initState() {
    super.initState();
  }

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
                    var tagSet2 = tagSet.doc();
                    await tagSet2.set({
                      'tagId': tagSet2.id,
                      'tag': tagController.text,
                      'tagColor': widget.categoryId['color'],
                      'categoryId': widget.categoryId['categoryId']
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 600,
                child: ListView(children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: tagSet
                        .where("categoryId",
                            isEqualTo: widget.categoryId['categoryId'])
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
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            snapshot.data!.docs[index];

                                        var Mytext = new Map();
                                        Mytext['tag'] = documentSnapshot['tag'];
                                        Mytext['tagColor'] =
                                            documentSnapshot['tagColor'];
                                        return Card(
                                          elevation: 2,
                                          child: ClipPath(
                                            child: Container(
                                              height: 80,
                                              child: Container(
                                                child: Container(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(
                                                              color: HexColor(
                                                                  Mytext[
                                                                      'tagColor']),
                                                              width: 10))),
                                                  child: ListTile(
                                                    title: Text(Mytext['tag']),
                                                    subtitle: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            OutlinedButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                Mytext['tag'],
                                                                style: const TextStyle(
                                                                    color:
                                                                        mobileSearchColor),
                                                              ),
                                                              style: OutlinedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  side: BorderSide(
                                                                      color: HexColor(
                                                                          Mytext[
                                                                              'tagColor']),
                                                                      width:
                                                                          2)),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    trailing:
                                                        SingleChildScrollView(
                                                      child: SizedBox(
                                                          width: 100,
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .edit),
                                                                  onPressed:
                                                                      () {}),
                                                              IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete),
                                                                  onPressed: () =>
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Are you sure?'),
                                                                            content:
                                                                                Text('This action cannot be undone.'),
                                                                            actions: [
                                                                              TextButton(
                                                                                child: Text('Cancel'),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                child: Text('OK'),
                                                                                onPressed: () {
                                                                                  _delete(documentSnapshot.id);
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      )),
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            clipper: ShapeBorderClipper(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3))),
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
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _create(),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

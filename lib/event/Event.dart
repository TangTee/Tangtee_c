import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tangteevs/HomePage.dart';
import 'package:tangteevs/utils/color.dart';
import 'package:tangteevs/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

// import 'AddTag.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadTag(),
    );
  }
}

class LoadTag extends StatefulWidget {
  const LoadTag({super.key});

  @override
  State<LoadTag> createState() => _LoadTagState();
}

class _LoadTagState extends State<LoadTag> {
  bool _isLoading = false;
  bool isDateSelect = false;

  final _post = FirebaseFirestore.instance.collection('post').doc();
  final _formKey = GlobalKey<FormState>();
  final _activityName = TextEditingController();
  final _place = TextEditingController();
  final _location = TextEditingController();
  final dateController = TextEditingController();
  final _time = TextEditingController();
  final _detail = TextEditingController();
  late var _tag = TextEditingController();
  final _peopleLimit = TextEditingController();
  var _tag2;
  var _tag2Color;

  void showModalBottomSheetC(BuildContext context, tag) {
    final CollectionReference _categorys =
        FirebaseFirestore.instance.collection('categorys');

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
          stream: _categorys.snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];

                  var Mytext = new Map();
                  Mytext['Category'] = documentSnapshot['Category'];
                  Mytext['categoryId'] = documentSnapshot['categoryId'];
                  Mytext['color'] = documentSnapshot['color'];

                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: HexColor(Mytext['color']),
                          textColor: white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          title: Center(
                              child: Text(Mytext['Category'],
                                  style: TextStyle(
                                      fontFamily: 'MyCustomFont',
                                      fontSize: 20))),
                          onTap: () {
                            showModalBottomSheetT(
                                context, Mytext['categoryId']);
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
        );
      },
    );
  }

  showModalBottomSheetT(BuildContext context, categoryId) {
    final CollectionReference _tags =
        FirebaseFirestore.instance.collection('tags');

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
          stream: _tags.where("categoryId", isEqualTo: categoryId).snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];

                  var Mytext = new Map();
                  Mytext['tag'] = documentSnapshot['tag'];
                  Mytext['tagColor'] = documentSnapshot['tagColor'];

                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: HexColor(Mytext['tagColor']),
                          textColor: white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          title: Center(
                              child: Text(
                            Mytext['tag'],
                            style: TextStyle(
                                fontFamily: 'MyCustomFont', fontSize: 20),
                          )),
                          onTap: () {
                            _tag2 = Mytext['tag'].toString();
                            _tag2Color = Mytext['tagColor'].toString();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            // ignore: void_checks
                            return _tag2;
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mobileBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _activityName,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                              color: mobileSearchColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MyCustomFont"),
                          suffixIcon: Icon(Icons.edit),
                          border: InputBorder.none,
                          hintText: 'Write your activity name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid activity name';
                          }
                          if (value.length > 25) {
                            return 'Limit at 25 characters ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _place,
                        decoration: textInputDecoration.copyWith(
                          labelStyle: const TextStyle(
                            color: mobileSearchColor,
                            fontFamily: "MyCustomFont",
                          ),
                          hintText: 'Place',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid place';
                          }
                          if (value.length > 25) {
                            return 'Limit at 25 characters ';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          controller: _location,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Location URL',
                              labelStyle: const TextStyle(
                                  fontFamily: "MyCustomFont",
                                  color: mobileSearchColor)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid location';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  child: TextField(
                                    controller: dateController,
                                    decoration: textInputDecoration.copyWith(
                                      prefixIcon: Icon(Icons.calendar_month),
                                      labelStyle: const TextStyle(
                                        color: mobileSearchColor,
                                        fontFamily: "MyCustomFont",
                                      ),
                                      hintText: '_ _ / _ _ / _ _ ',
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:
                                            DateTime(DateTime.now().year + 1),
                                      );

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy/MM/dd')
                                                .format(pickedDate);
                                        setState(() {
                                          isDateSelect = true;
                                          dateController.text = formattedDate;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (isDateSelect == false)
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: TextField(
                                      controller: _time,
                                      decoration: textInputDecoration.copyWith(
                                          enabled: false,
                                          labelStyle: const TextStyle(
                                            color: mobileSearchColor,
                                            fontFamily: "MyCustomFont",
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            borderSide: BorderSide(
                                                color: disable, width: 2),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.query_builder,
                                          ),
                                          hintText: "_ _ : _ _ "),
                                      readOnly: true,
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        TimeOfDay now = TimeOfDay.now();
                                        int nowInMinutes =
                                            now.hour * 60 + now.minute + 60;
                                        int pickedInMinutes =
                                            pickedTime!.hour * 60 +
                                                pickedTime.minute;

                                        if (pickedInMinutes > nowInMinutes) {
                                          setState(() {
                                            _time.text =
                                                pickedTime.format(context);
                                          });
                                          // } else {
                                          //   print("Time is not selected");
                                          // }
                                        } else if (pickedInMinutes <
                                            nowInMinutes) {
                                          return print("Please selec time ...");
                                        } else {
                                          print("Time is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    child: TextField(
                                      controller: _time,
                                      decoration: textInputDecoration.copyWith(
                                          labelStyle: const TextStyle(
                                            color: mobileSearchColor,
                                            fontFamily: "MyCustomFont",
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.query_builder,
                                          ),
                                          hintText: "_ _ : _ _ "),
                                      readOnly: true,
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        TimeOfDay now = TimeOfDay.now();
                                        int nowInMinutes =
                                            now.hour * 60 + now.minute + 60;
                                        int pickedInMinutes =
                                            pickedTime!.hour * 60 +
                                                pickedTime.minute;

                                        if (pickedInMinutes > nowInMinutes) {
                                          setState(() {
                                            _time.text =
                                                pickedTime.format(context);
                                          });
                                          // } else {
                                          //   print("Time is not selected");
                                          // }
                                        } else if (pickedInMinutes <
                                            nowInMinutes) {
                                          return print("Please selec time ...");
                                        } else {
                                          print("Time is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.16,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: TextFormField(
                              maxLines: 3,
                              controller: _detail,
                              decoration: textInputDecoration.copyWith(
                                labelStyle: const TextStyle(
                                  color: mobileSearchColor,
                                  fontFamily: "MyCustomFont",
                                ),
                                hintText: 'Detail',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid detail';
                                }
                                if (value.length > 150) {
                                  return 'Limit at 150 characters ';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: TextFormField(
                            controller: _peopleLimit,
                            decoration: textInputDecoration.copyWith(
                              labelStyle: const TextStyle(
                                color: mobileSearchColor,
                                fontFamily: "MyCustomFont",
                              ),
                              hintText: 'People Limit',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid people limit';
                              } else if (int.parse(value) >= 100) {
                                return 'people must less than 100';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                showModalBottomSheetC(context, _tag);
                                setState(() {
                                  _tag =
                                      _tag2.toString() as TextEditingController;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: mobileSearchColor,
                              ),
                              child: Container(
                                width: 50,
                                child: Row(
                                  children: const [
                                    Icon(Icons.add),
                                    Text('Tag')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 90.0,
                          height: 50,
                          child: ElevatedButton(
                            child: Text(
                              "Post",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: green),
                            onPressed: () async {
                              if (_formKey.currentState!.validate() == true) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await _post.set({
                                  'postid': _post.id,
                                  'activityName': _activityName.text,
                                  'place': _place.text,
                                  'location': _location.text,
                                  'date': dateController.text,
                                  'time': _time.text,
                                  'detail': _detail.text,
                                  'peopleLimit': _peopleLimit.text,
                                  'likes': [],
                                  'waiting': [],
                                  'join': [],
                                  'tag': _tag2,
                                  'tagColor': _tag2Color,
                                  'timeStamp': FieldValue.serverTimestamp(),
                                  'uid': FirebaseAuth.instance.currentUser?.uid,
                                }).whenComplete(() {
                                  nextScreenReplaceOut(context, MyHomePage());
                                });
                                //await _post.set(post);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initState() {
    dateController.text = "";
    _time.text = "";
    super.initState();
  }
}

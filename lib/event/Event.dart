import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tangteevs/HomePage.dart';
import 'package:tangteevs/utils/color.dart';
import 'package:tangteevs/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

import '../utils/color.dart';
import '../utils/showSnackbar.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
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
  final _tag = TextEditingController();
  final _peopleLimit = TextEditingController();

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
                              color: Colors.black,
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
                            color: Colors.black,
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
                                  color: Colors.black)),
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
                                            color: Colors.black,
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
                                            color: Colors.black,
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
                                  color: Colors.black,
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
                                color: Colors.black,
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
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
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

  void _showModalBottomSheet(BuildContext context, uid) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // if (postData['uid'].toString() == uid)
              //   ListTile(
              //     contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              //     title: Center(
              //       child: Text(
              //         'Edit Activity',
              //         style:
              //             TextStyle(fontFamily: 'MyCustomFont', fontSize: 20),
              //       ),
              //     ),
              //     onTap: () {
              //       Navigator.of(context, rootNavigator: true)
              //           .pushAndRemoveUntil(
              //         MaterialPageRoute(
              //           builder: (BuildContext context) {
              //             return EditAct(
              //               postid: widget.snap['postid'],
              //             );
              //           },
              //         ),
              //         (_) => false,
              //       );
              //     },
              //   ),

              // if (postData['uid'].toString() == uid)
              //   ListTile(
              //     contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              //     title: const Center(
              //       child: Text(
              //         'Delete',
              //         style: TextStyle(
              //             fontFamily: 'MyCustomFont',
              //             fontSize: 20,
              //             color: redColor),
              //       ),
              //     ),
              //     onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) => AlertDialog(
              //                 title: Text('Delete Activity'),
              //                 content: Text(
              //                     'Are you sure you want to permanently\nremove this Activity from Tungtee?'),
              //                 actions: [
              //                   TextButton(
              //                       onPressed: () => Navigator.pop(context),
              //                       child: Text('Cancle')),
              //                   TextButton(
              //                       onPressed: (() {
              //                         FirebaseFirestore.instance
              //                             .collection('post')
              //                             .doc(widget.snap['postid'])
              //                             .delete()
              //                             .whenComplete(() {
              //                           Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                               builder: (context) => MyHomePage(),
              //                             ),
              //                           );
              //                         });
              //                       }),
              //                       child: Text('Delete'))
              //                 ],
              //               ));
              //     },
              //   ),
              // if (postData['uid'].toString() != uid)
              //   ListTile(
              //     contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              //     title: const Center(
              //         child: Text(
              //       'Report',
              //       style: TextStyle(
              //           color: redColor,
              //           fontFamily: 'MyCustomFont',
              //           fontSize: 20),
              //     )),
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ListTile(
              //   contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              //   title: const Center(
              //       child: Text(
              //     'Cancel',
              //     style: TextStyle(
              //         color: redColor,
              //         fontFamily: 'MyCustomFont',
              //         fontSize: 20),
              //   )),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  void initState() {
    dateController.text = "";
    _time.text = "";
    super.initState();
  }
}

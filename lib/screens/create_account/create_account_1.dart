// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateAccount1 extends StatefulWidget {
  const CreateAccount1({Key? key}) : super(key: key);
  static String route = '/CreateAccount1';

  @override
  State<CreateAccount1> createState() => _CreateAccount1State();
}

class _CreateAccount1State extends State<CreateAccount1> {
  late TextEditingController _namefield, _emailfield, _datefield;
  late double screenHeight, topGap, nextButtomSize;

  late String CreateAccountStr;
  bool nextActive = false;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _namefield = TextEditingController();
    _emailfield = TextEditingController();
    _datefield = TextEditingController();
    _emailfield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
    _datefield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
    _namefield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
  }

  bool ValidateEmailOrPhone() {
    String p = _emailfield.text;
    RegExp regMail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    RegExp regPhone = RegExp(r"^01[0-2,5]{1}[0-9]{8}$");
    return regMail.hasMatch(p) || regPhone.hasMatch(p);
  }

  bool DisableButton() {
    if (_namefield.text.isEmpty ||
        _emailfield.text.isEmpty ||
        _datefield.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _namefield.dispose();
    _emailfield.dispose();
    _datefield.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    topGap = 1;
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        CreateAccountStr = "Create your \naccount";
        topGap = 1;
        nextButtomSize = 0.8;
      } else {
        CreateAccountStr = "Create your account";
        topGap = 0.5;
        nextButtomSize = 0.88;
      }
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: MyAppBar(),
              body: SingleChildScrollView(
                reverse: true,
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CreateAccountText(),
                      NameField(),
                      EmailField(),
                      DateWidget(),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ButtomBar()),
        ),
      );
    });
  }

  PreferredSizeWidget MyAppBar() => AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/twitter_logo.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
  Widget CreateAccountText() => Padding(
        padding: EdgeInsets.only(
            left: 30, top: 0.025 * screenHeight), //left = 30, top = 20
        child: Text(
          CreateAccountStr,
          style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
        ),
      );
  Widget DateWidget() => Padding(
        padding: const EdgeInsets.fromLTRB(35, 0, 30, 0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _datefield,
              readOnly: true,
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1950, 1, 1),
                    maxTime: DateTime.now(),
                    currentTime: DateTime.now(), onConfirm: (date) {
                  _datefield.text = '${date.year}-${date.month}-${date.day}';
                }, locale: LocaleType.en);
              },
              decoration: const InputDecoration(
                  hintText: "Date of birth",
                  hintStyle: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))),
            )),
      );
  Widget EmailField() => Padding(
        padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              validator: (Value) {
                if (ValidateEmailOrPhone()) {
                  log("success");
                  return null;
                } else {
                  log("fail");
                  return "Enter Valid Email or Phone";
                }
              },
              controller: _emailfield,
              decoration: InputDecoration(
                  hintText: "Phone number or email address",
                  hintStyle: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))),
            )),
      );
  Widget NameField() => Padding(
        padding: EdgeInsets.fromLTRB(
            35, 0.127 * screenHeight * topGap, 30, 0), //35, 100, 30, 0
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _namefield,
              maxLength: 50,
              decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))),
            )),
      );
  Widget ButtomBar() => Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * nextButtomSize),
            child: Transform.translate(
              offset: Offset(-15, -5),
              child: ElevatedButton(
                  onPressed: nextActive
                      ? () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.pushNamed(context, '/CreateAccount2',
                                arguments: {
                                  'name': _namefield.text,
                                  'email': _emailfield.text,
                                  'date': _datefield.text
                                });
                          }
                        }
                      : null,
                  child: const Text("next"),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))))),
            ),
          ),
        ),
      );
}

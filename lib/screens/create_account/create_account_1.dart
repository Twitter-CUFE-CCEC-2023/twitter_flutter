// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import '../../utils/common_listners/network_listner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateAccount1 extends StatefulWidget {
  const CreateAccount1({Key? key}) : super(key: key);
  static String route = '/CreateAccount1';

  @override
  State<CreateAccount1> createState() => _CreateAccount1State();
}

class _CreateAccount1State extends State<CreateAccount1> {
  late TextEditingController _namefield,
      _emailfield,
      _datefield,
      _usernamefield;
  late double screenHeight, topGap, nextButtomSize;
  List<String> gender = ['Male', 'Female'];
  String? selected_gender = 'Male';
  late String CreateAccountStr;
  bool nextActive = false;
  late String mydate;
  Icon emailCheckSuffix = const Icon(null);
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _namefield = TextEditingController();
    _emailfield = TextEditingController();
    _datefield = TextEditingController();
    _usernamefield = TextEditingController();
    _emailfield.addListener(() {
      emailCheckSuffix = ValidateEmailOrPhone()
          ? const Icon(
              Icons.check_circle_outline_sharp,
              size: 25.0,
              color: Color(0xFF2DB169),
            )
          : const Icon(null);
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
    _usernamefield.addListener(() {
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
        _datefield.text.isEmpty ||
        _usernamefield.text.isEmpty) {
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
    _usernamefield.dispose();
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
                      usernameField(),
                      EmailField(),
                      genderField(),
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

  Widget genderField() => Padding(
        padding: EdgeInsets.fromLTRB(35, 5, 30, 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DropdownButton<String>(
              value: selected_gender,
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              isExpanded: true,
              items: gender.map(BuildMenuItem).toList(),
              onChanged: (value) => setState(() {
                    selected_gender = value;
                  })),
        ),
      );
  DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style:
              TextStyle(fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))));
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
                  mydate = date.toIso8601String();
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
        padding: EdgeInsets.fromLTRB(35, 5, 30, 10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              validator: (Value) {
                if (ValidateEmailOrPhone()) {
                  return null;
                } else {
                  return "Enter Valid Email or Phone";
                }
              },
              controller: _emailfield,
              decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (emailCheckSuffix.icon != null) emailCheckSuffix, // c
                    ],
                  ),
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
  Widget usernameField() => Padding(
        padding: EdgeInsets.fromLTRB(35, 0, 30, 10), //35, 100, 30, 0
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _usernamefield,
              decoration: InputDecoration(
                  hintText: "Username",
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
              child: BlocListener<InternetCubit, InternetState>(
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) => networkListner(context, state),
                child: ElevatedButton(
                    onPressed: nextActive
                        ? () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/CreateAccount2',
                                  arguments: {
                                    'name': _namefield.text,
                                    'email': _emailfield.text,
                                    'date': mydate,
                                    'username': _usernamefield.text,
                                    'gender': selected_gender,
                                    'dateShow': _datefield.text
                                  });
                            }
                          }
                        : null,
                    child: const Text("next"),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0))))),
              ),
            ),
          ),
        ),
      );
}

// ignore_for_file: prefer_const_constructors
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
  bool NextActive = false;

  @override
  void initState() {
    super.initState();
    _namefield = TextEditingController();
    _emailfield = TextEditingController();
    _datefield = TextEditingController();
    _emailfield.addListener(() {
      setState(() {
        this.NextActive = DisableButton();
      });
    });
    _datefield.addListener(() {
      setState(() {
        this.NextActive = DisableButton();
      });
    });
    _namefield.addListener(() {
      setState(() {
        this.NextActive = DisableButton();
      });
    });
  }

  @override
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
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/images/twitter_logo.png',
              fit: BoxFit.cover,
              width: 40,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blue),
              onPressed: null,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  "Create your \naccount",
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 100, 30, 0),
                child: SizedBox(
                    width: 320,
                    child: TextField(
                      // onChanged: DisableButton(),
                      controller: _namefield,
                      maxLength: 50,
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 88, 85, 85))),
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
                child: SizedBox(
                    width: 320,
                    child: TextField(
                      controller: _emailfield,
                      decoration: InputDecoration(
                          hintText: "Phone number or email address",
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 88, 85, 85))),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 30, 0),
                child: SizedBox(
                    width: 320,
                    child: TextField(
                      controller: _datefield,
                      readOnly: true,
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1950, 1, 1),
                            maxTime: DateTime.now(),
                            currentTime: DateTime.now(), onConfirm: (date) {
                          _datefield.text =
                              '${date.year}-${date.month}-${date.day}';
                        }, locale: LocaleType.en);
                      },
                      decoration: const InputDecoration(
                          hintText: "Date of birth",
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 88, 85, 85))),
                    )),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(310, 280, 0, 0),
                child: Transform.translate(
                  offset: Offset(
                      0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
                  child: ElevatedButton(
                      onPressed: NextActive
                          ? () {
                              Navigator.pushNamed(context, '/CreateAccount2',
                                  arguments: {
                                    'name': _namefield.text,
                                    'email': _emailfield.text,
                                    'date': _datefield.text
                                  });
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

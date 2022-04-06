// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';

class CreateAccount4 extends StatefulWidget {
  const CreateAccount4({Key? key}) : super(key: key);
  static String route = '/CreateAccount4';
  @override
  State<CreateAccount4> createState() => _CreateAccount4State();
}

class _CreateAccount4State extends State<CreateAccount4> {
  bool nextActive = true;
  bool _passwordVisible = false;
  late TextEditingController _passwordfield;

  @override
  void initState() {
    super.initState();
    _passwordfield = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double nextButtomSize = 0.8;
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        nextButtomSize = 0.8;
      } else {
        nextButtomSize = 0.88;
      }
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          top: 0.025 * screenHeight), //left = 30, top = 20
                      child: Text(
                        "You'll need a password",
                        style: TextStyle(
                            fontSize: 31, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          top: 0.025 * screenHeight), //left = 30, top = 20
                      child: Text(
                        "Make sure it's 8 characters or more.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordfield,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ]),
            ),
            bottomNavigationBar: Transform.translate(
              offset:
                  Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
              child: BottomAppBar(
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width *
                          nextButtomSize), //310
                  child: Transform.translate(
                    offset: Offset(-15, -5),
                    child: ElevatedButton(
                        onPressed: nextActive
                            ? () {
                                // TODO: Add route
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/HomePage',
                                    (Route<dynamic> route) => false);
                              }
                            : null,
                        child: const Text("next"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0))))),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

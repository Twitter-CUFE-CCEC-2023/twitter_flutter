import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget Message(
    {required String message,
    required double fontSize,
    required Color colors}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35), // 35
    child: AutoSizeText(
      message,
      style: TextStyle(fontSize: fontSize, color: colors),
      maxLines: 2,
    ),
  );
}

Widget textfield(
    {required String message,
    required String message2,
    required double width}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
    child: SizedBox(
        width: width,
        child: TextField(
          decoration: InputDecoration(
            labelText: message,
            hintText: message2,
          ),
        )),
  );
}

class ChangePassword extends StatefulWidget {
  static String route = '/ChangePassword';

  const ChangePassword({Key? key}) : super(key: key);
  changepassword createState() => changepassword();
}

class changepassword extends State<ChangePassword> {
  bool isButtonActive = true;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        sizedBoxHeightMultiplier[1] = 1;
        sizedBoxHeightMultiplier[2] = 1;
        imageMultiplier[0] = 1;
        imageMultiplier[1] = 1;
        borderRadiusMultiplier = 1;
        fontSizeMultiplier[0] = 1;
        fontSizeMultiplier[1] = 1;
        fontSizeMultiplier[2] = 1;
        fontSizeMultiplier[3] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        sizedBoxHeightMultiplier[1] = .33;
        sizedBoxHeightMultiplier[2] = 1;
        sizedBoxHeightMultiplier[3] = 1.8;
        imageMultiplier[0] = 1.8;
        imageMultiplier[1] = 1.8;
        borderRadiusMultiplier = 1.4;
        fontSizeMultiplier[0] = 2;
        fontSizeMultiplier[1] = 2;
        fontSizeMultiplier[2] = 2;
        fontSizeMultiplier[3] = 2;
      }
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context, false)),
          backgroundColor: Colors.white,
          title: SizedBox.fromSize(
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Update Password',
                  style: TextStyle(
                    fontSize: 0.025 * fontSizeMultiplier[0] * screenHeight,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '@username ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 0.023 * fontSizeMultiplier[0] * screenHeight,
                  ),
                ),
              ),
            ]),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Positioned(
                top: 0,
                child: Column(
                  children: <Widget>[
                    //    ),
                    textfield(
                        message: 'Current Password',
                        message2: '',
                        width: screenWidth - 50),

                    Container(
                      height: 10,
                    ),
                    textfield(
                        message: 'New Password',
                        message2: 'At least 8 characters',
                        width: screenWidth - 50),

                    Container(
                      height: 10,
                    ),
                    textfield(
                        message: 'Confirm Password',
                        message2: 'At least 8 characters',
                        width: screenWidth - 50),

                    Container(
                      height: 20,
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(5000),
                      child: SizedBox(
                        width: screenWidth / 2,
                        height: 45,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          disabledColor: Colors.lightBlueAccent,
                          disabledElevation: 54,
                          onPressed: isButtonActive
                              ? () {
                                  setState(() => isButtonActive = false);
                                }
                              : null,
                          child: const Text(
                            'Update password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(height: 10),
                    SizedBox(
                        width: screenWidth,
                        height: 20,
                        child: Center(
                          child: Message(
                              fontSize: 15,
                              message: 'Forgotten your password?',
                              colors: Colors.black54),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      //);
    });
  }
}

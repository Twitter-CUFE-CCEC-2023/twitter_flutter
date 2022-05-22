import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../profile/followers.dart';
import 'forget_password2.dart';

class ForgetPassword extends StatefulWidget {
  static String route = '/ForgetPassword';
  const ForgetPassword({Key? key}) : super(key: key);
  @override
  forgetpassword createState() => forgetpassword();
}

class forgetpassword extends State<ForgetPassword> {
  late TextEditingController _usernamefield;

  @override
  void initState() {

    super.initState();
    _usernamefield = TextEditingController();
  }


  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return AutoSizeText(
        message,
        style: TextStyle(fontSize: fontSize, color: colors),
        maxLines: 2,
    );
  }

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  Widget textfieldController({
    required int lines,
    required double width,
    required TextEditingController controller,
    required double fontSizeMultiplier,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: SizedBox(
          width: width*3/4,
          height: 34,
          child: TextFormField(
            enabled: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: lines,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        fontSizeMultiplier[0] = 2;
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                ),
                onPressed: () => Navigator.pop(context, false)),
            backgroundColor: Colors.white,
            title: SizedBox.fromSize(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change password',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 0.0255 * fontSizeMultiplier[0] * screenHeight,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,


          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10, bottom: 5),
                  child: Text('Find your twitter account',
                      style: TextStyle(fontSize:0.0282 * fontSizeMultiplier[0] * screenHeight,fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10, bottom: 20),
                  child: Message(message: 'Enter your email, phone number, or username.', fontSize: 0.0181 * fontSizeMultiplier[0] * screenHeight, colors: Colors.black87),
                ),

          Padding(
            padding: const EdgeInsets.only(left: 0,top: 10, bottom: 25),
                child:textfieldController(
                      lines: 1,
                      fontSizeMultiplier:
                      0.0192 * fontSizeMultiplier[0] * screenHeight,
                      controller: _usernamefield,
                      width: screenWidth-20),),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child:ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    width: screenWidth/4.33,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(
                            context, ForgetPassword2.route,
                            arguments: _usernamefield.text);
                      },

                      child:  Message(message: 'Search', fontSize: 0.0233 * fontSizeMultiplier[0] * screenHeight, colors: Colors.white),

                      ),
                    ),
                  ),
                )
          ],
            ),
          ),
        ),
      );
      //);
    });
  }
}

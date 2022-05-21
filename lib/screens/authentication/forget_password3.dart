import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'forget_password4.dart';

class ForgetPassword3 extends StatefulWidget {
  static String route = '/ForgetPassword3';
  const ForgetPassword3({Key? key}) : super(key: key);
  @override
  forgetpassword3 createState() => forgetpassword3();
}

class forgetpassword3 extends State<ForgetPassword3> {
  late TextEditingController _verifyfield;

  @override
  void initState() {

    super.initState();
    _verifyfield = TextEditingController();
  }



  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return AutoSizeText(
        message,
        style: TextStyle(fontSize: fontSize, color: colors),
    );
  }
  Widget textfieldController({
    required String message,
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
              hintText: message,
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
                  padding: const EdgeInsets.only(left: 10,top: 25, bottom: 5),
                  child: Text('Check your email',
                      style: TextStyle(fontSize: 0.0282 * fontSizeMultiplier[0] * screenHeight, color: Colors.black,fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10, bottom: 20),
                  child: Message(message: "You'll receive a code to verify here so you can reset your account password", fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight, colors: Colors.black87),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 0,top: 10, bottom: 25),
                  child:textfieldController(
                      message: 'Enter your code',
                      lines: 1,
                      fontSizeMultiplier:
                      0.0192 * fontSizeMultiplier[0] * screenHeight,
                      controller: _verifyfield,
                      width: screenWidth-20),),

                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: screenWidth/5,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: (){

                            Navigator.pushNamed(
                                context, ForgetPassword4.route,
                                arguments: _verifyfield.text);
                          },

                          child: Message(message: 'Verify', fontSize: 0.0233 * fontSizeMultiplier[0] * screenHeight, colors: Colors.white),
                        ),
                      ),
                    )
                ),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 15, bottom: 25),
            child:Message(message:"If you don't see the email,check other places it might be, like your junk, spam, social, or other folders",fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight,colors: Colors.black87),
          ),

                TextButton(onPressed: (){}, child: Message(message: "Didn't receive your code?", fontSize: 0.0181  * fontSizeMultiplier[0] * screenHeight, colors: Colors.blue))
              ],
            ),
          ),
        ),
      );
      //);
    });
  }
}

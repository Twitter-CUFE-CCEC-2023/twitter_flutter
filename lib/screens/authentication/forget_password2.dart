import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'forget_password3.dart';



class ForgetPassword2 extends StatefulWidget {
  static String route = '/ForgetPassword2';
  const ForgetPassword2({Key? key}) : super(key: key);
  @override
  forgetpassword2 createState() => forgetpassword2();
}

class forgetpassword2 extends State<ForgetPassword2> {
  late String username;
  late int selectedRadioTile;
  late int selectedRadio;
  late String result;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 1;
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }


  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return  AutoSizeText(
        message,
        style: TextStyle(fontSize: fontSize, color: colors),
        maxLines: 2,

    );
  }

  @override
  Widget build(BuildContext context) {
    username = ModalRoute.of(context)!.settings.arguments as String;
    result = username.replaceAll(new RegExp('(?<=..)[^@.](?<=.)'), '*');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        imageMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        imageMultiplier[0] = 1.8;
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
                    fontSize:0.0255* fontSizeMultiplier[0] * screenHeight,
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
                  padding:const EdgeInsets.only(left: 10,top: 25, bottom: 5),
                  child: Text('How do you want to reset your password?',
                      style: TextStyle(fontSize:0.0282 * fontSizeMultiplier[0] * screenHeight, color: Colors.black,fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10, bottom: 20),
                  child: Message(message: 'You can use the information associated with your account.', fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight, colors: Colors.black87),
                ),

          RadioListTile(
            contentPadding: const EdgeInsets.only(left: 0),
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Text("Send an email to "+result,style: TextStyle(fontSize: 0.0212 * fontSizeMultiplier[0] * screenHeight,color: Colors.black)),
                  onChanged: (val) {
                    setSelectedRadioTile(val as int);
                  },
                  activeColor: Colors.blue,

                  selected: true,
                ),

                Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 70,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(
                                context, ForgetPassword3.route);
                          },

                          child: Message(message: 'Next', fontSize: 0.0233 * fontSizeMultiplier[0] * screenHeight, colors: Colors.white),
                        ),
                      ),
                    )
                ),

                TextButton(onPressed: (){}, child: Message(message: "Don't have access to these?", fontSize: 0.0181  * fontSizeMultiplier[0] * screenHeight, colors: Colors.blue))

              ],
            ),
          ),
        ),
      );
      //);
    });
  }
}

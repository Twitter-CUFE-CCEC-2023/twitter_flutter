import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/screens/starting_page.dart';
import '../../blocs/forget_password/forget_password_bloc.dart';
import '../../blocs/forget_password/forget_password_events.dart';
import '../../blocs/forget_password/forget_password_states.dart';
import '../../models/objects/user.dart';
import 'forget_password3.dart';

class ForgetPassword4 extends StatefulWidget {
  static String route = '/ForgetPassword4';
  const ForgetPassword4({Key? key}) : super(key: key);
  @override
  forgetpassword4 createState() => forgetpassword4();
}

class forgetpassword4 extends State<ForgetPassword4> {
  Widget? bottomSheet = null;
  late String verificationCode;
  late TextEditingController password;
  late TextEditingController confirmpassword;
  bool value = false;
  late UserModel? userData;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  void dispose() {
    confirmpassword.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    password = TextEditingController();
    confirmpassword = TextEditingController();

    confirmpassword.addListener(() {
      setState(() {
      });
    });
    password.addListener(() {
      setState(() {
      });
    });
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
    required int lines,
    required double width,
    required TextEditingController controller,
    required double fontSizeMultiplier,
    required validator
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: SizedBox(
          width: width*3/4,
          height: 60,
          child: TextFormField(
            validator: validator,
            enabled: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: lines,
            decoration: InputDecoration(
              counterText: ' ',
                contentPadding: const EdgeInsets.all(5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          )),
    );
  }
  String? ValidateConfirmpassword(String? value) {
    if (value == null) {
      return 'Please re-enter password';
    }
    if (password.text != confirmpassword.text) {
      return "Password does not match";
    }
    return null;
  }

  String? Validatepassword(String? value) {
    if (value == null) {
      return 'Please Enter password';
    } else if (value.length < 8) {
      return 'Please enter a new password.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
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
          bottomSheet: bottomSheet,
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
                  child: Text('Reset your password',
                      style: TextStyle(fontSize: 0.0282 * fontSizeMultiplier[0] * screenHeight, color: Colors.black,fontWeight: FontWeight.bold)),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10, bottom: 20),
                  child: Message(message: "Strong passwords include numbers,letters,and punctuation marks.", fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight, colors: Colors.black87),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child:Message(message:'Enter your new password', fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight, colors: Colors.black87,),),
          Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [textfieldController(
                    validator: Validatepassword,
                      lines: 1,
                      fontSizeMultiplier:
                      0.0192 * fontSizeMultiplier[0] * screenHeight,
                      controller: password,
                      width: screenWidth-20,
                  ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
                child:Message(message:'Enter your password one more time', fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight, colors: Colors.black87,),),

                Padding(
                  padding: const EdgeInsets.only(left: 0,top: 0, bottom: 0),
                  child:textfieldController(
                    validator: ValidateConfirmpassword,
                      lines: 1,
                      fontSizeMultiplier:
                      0.0192 * fontSizeMultiplier[0] * screenHeight,
                      controller: confirmpassword,
                      width: screenWidth-20),),]),),

                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 0.0, bottom: 00.0),
                  activeColor: Colors.blue,
                  value: value,
                  onChanged: (value) => setState(() => this.value = value!),
                  title: Message(
                      message:
                      'Remember Me',
                      fontSize: 0.0192*
                          fontSizeMultiplier[0] *
                          screenHeight, // 30
                      colors: Colors.black87
                    // family: 'IBMPlexSans',
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5, bottom: 25,right: 10),
                  child:Message(message:"Resetting your password will log you out of all your active Twitter sessions.",fontSize: 0.0192 * fontSizeMultiplier[0] * screenHeight,colors: Colors.black87),
                ),

                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: screenWidth/2.5,
                        height: 35,
                        child: BlocListener<ForgetPasswordBloc,
                            ForgetPasswordStates>(
                          listener: (context, state) {
                            if (state is ForgetPasswordSuccessState) {
                              try {
                                //TODO:Add bottom sheet to show success Message

                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    StartingPage.route,
                                        (route) => route == ForgetPassword4.route);
                              } on Exception catch (e) {
                                context
                                    .read<ForgetPasswordBloc>()
                                    .add(StartEvent());
                              }
                            } else if (state is ForgetPasswordFailureState) {
                              //TODO:Add bottom sheet to show Failure Message
                              setState(() {
                                bottomSheet =
                                    _buildBottomSheet(context, state);
                              });

                            }
                          },
                          child: ElevatedButton(
                          onPressed: (){
                             if (_formkey.currentState!.validate()) {
                               String user_name = args.username;
                               int resetPasswordCode = int.parse(args.code);
                               String pass = password.text;
                               context.read<ForgetPasswordBloc>().add(
                                   ForgetPasswordButtonPressed(username: user_name,resetPasswordCode: resetPasswordCode,password: pass

                                   ));
                             }
                          },

                          child: Message(message: 'Reset password', fontSize: 0.0233 * fontSizeMultiplier[0] * screenHeight, colors: Colors.white),
                        ),
                      ),
                    )
                ),
                )],
            ),
          ),
        ),
      );
      //);
    });
  }
  Widget _buildBottomSheet(context, state) {
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom / 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

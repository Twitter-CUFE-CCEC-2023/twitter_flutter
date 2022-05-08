// ignore_for_file: prefer_const_constructors, file_names
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/screens/create_account/VerificationCode.dart';
import '../../utils/common_listners/network_listner.dart';
import 'package:twitter_flutter/widgets/authentication/bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../widgets/authentication/constants.dart';

class CreateAccount4 extends StatefulWidget {
  const CreateAccount4({Key? key}) : super(key: key);
  static String route = '/CreateAccount4';
  @override
  State<CreateAccount4> createState() => _CreateAccount4State();
}

class _CreateAccount4State extends State<CreateAccount4> {
  bool nextActive = false, _passwordVisible = false;
  Icon passwordCheckSuffix = const Icon(null);

  late double screenHeight, nextButtomSize;
  late TextEditingController _passwordfield;
  final _formkey = GlobalKey<FormState>();
  late Map<String, String?> data;
  late DateTime date;
  Widget? bottomSheet = null;

  @override
  void initState() {
    super.initState();
    _passwordfield = TextEditingController();

    _passwordfield.addListener(() {
      setState(() {
        passwordCheckSuffix = _passwordfield.text.length >= 8
            ? const Icon(
                Icons.check_circle_outline_sharp,
                size: 25.0,
                color: Color(0xFF2DB169),
              )
            : const Icon(null);
        nextActive = _passwordfield.text.isEmpty ? false : true;
      });
    });
  }

  @override
  void dispose() {
    _passwordfield.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    nextButtomSize = 0.8;
    data = ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        nextButtomSize = 0.8;
      } else {
        nextButtomSize = 0.88;
      }
      return BlocConsumer<UserManagementBloc,UserManagementStates>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
             try {
                Navigator.pushNamedAndRemoveUntil(context, VerificationCode.route,
                        (Route<dynamic> route) => false);
              } on Exception catch (e) {
                context.read<UserManagementBloc>().add(StartEvent());
              }
            } else if (state is SignupFailureState) {
              setState(() {
                bottomSheet = buildBottomSheet(context, state);
              });

            }
          },
        builder: (context,state) {
          if(state is LoadingState)
            {
              return Container(
                color: Colors.lightBlue,
                child: SpinKitFadingCircle(
                  color: Colors.white,
                ),
              );
            }
          else {
            return GestureDetector(
            onTap: (){
              setState(() {
                bottomSheet = null;
              });
            },
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  bottomSheet: bottomSheet,

                  resizeToAvoidBottomInset: false,
                  appBar: myAppBar(),
                  body: SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: _formkey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            widget1(),
                            widget2(),
                            passwordField(),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).viewInsets.bottom)),
                          ]),
                    ),
                  ),
                  bottomNavigationBar: nextButton(),
                ),
              ),
            ),
          );
          }
        }
      );
    });
  }

  PreferredSizeWidget myAppBar() => AppBar(
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
  Widget widget1() => Padding(
        padding: EdgeInsets.only(
            left: 20, top: 0.025 * screenHeight), //left = 30, top = 20
        child: Text(
          "You'll need a password",
          style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
        ),
      );
  Widget widget2() => Padding(
        padding: EdgeInsets.only(
            left: 20, top: 0.025 * screenHeight), //left = 30, top = 20
        child: Text(
          "Make sure it's 8 characters or more.",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
      );
  Widget passwordField() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: TextFormField(
          validator: (value) {
            if (value!.length >= 8) {
              return null;
            } else {
              return "Enter atleast 8 characters";
            }
          },
          keyboardType: TextInputType.text,
          controller: _passwordfield,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
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
                  if (passwordCheckSuffix.icon != null)
                    passwordCheckSuffix, // check that the icon suffix is not set to null
                ]),
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
  Widget nextButton() => Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * nextButtomSize), //310
            child: Transform.translate(
              offset: Offset(-15, -5),
              child: ElevatedButton(
                  onPressed: nextActive
                      ? () {
                          if (_formkey.currentState!.validate()) {
                            context.read<UserManagementBloc>().add(SignupButtonPressed(
                                name: data['name'].toString(),
                                password: _passwordfield.text,
                                email: data['email'].toString(),
                                date: data['date'].toString(),
                                username: data['username'].toString(),
                                gender: data['gender'].toString()));
                          }
                        }
                      : null,
                  child: const Text("next"),
                  style: elevatedButtonsStyle
              ),
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import '../../utils/common_listners/network_listner.dart';
import '../../widgets/authentication/appBar.dart';
import 'login_password.dart';

class LoginUsername extends StatefulWidget {
  const LoginUsername({Key? key}) : super(key: key);
  static const String route = "LoginUsername";

  @override
  State<LoginUsername> createState() => _LoginUsernameState();
}

class _LoginUsernameState extends State<LoginUsername> {
  bool nextActive = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final bool nextActive = controller.text.isNotEmpty;
      setState(() {
        this.nextActive = nextActive;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageMultiplier;
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        imageMultiplier = 1;
      } else {
        imageMultiplier = 1.8;
      }
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: generalAppBar(context,imageMultiplier),
            body: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 30.0, top: 20.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "To get started, first enter your phone, email address or @username",
                    style: dispTextStyle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  TextField(
                    showCursor: true,
                    cursorHeight: 25.0,
                    textAlign: TextAlign.left,
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Phone, email address, or username",
                      hintStyle: TextStyle(fontSize: 18.0),
                      isDense: true,
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Transform.translate(
              offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
              child: BottomAppBar(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      color: Color(0xffD9DCDD),
                      thickness: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 12.0, top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              //TODO:Forget Password Button
                            },
                            child: const Text("Forget Password?"),
                            style: outlinedButtonsStyle,
                          ),
                          BlocListener<InternetCubit,InternetState>(
                            listenWhen: (previousState,currentState)=> previousState != currentState,
                            listener: (context, state) => networkListner(context,state),
                            child: ElevatedButton(
                              onPressed: nextActive
                                  ? () {
                                      Navigator.pushNamed(
                                          context, LoginPassword.route,
                                          arguments: controller.text);
                                    }
                                  : null,
                              child: const Text("Next"),
                              style: elevatedButtonsStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

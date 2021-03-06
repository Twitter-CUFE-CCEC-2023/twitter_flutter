import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/screens/profile/pre_home_page.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';
import '../../utils/common_listners/network_listner.dart';
import '../../widgets/authentication/appBar.dart';
import 'forget_password1.dart';

class LoginPassword extends StatefulWidget {
  static const String route = "/LoginPassword";
  const LoginPassword({Key? key}) : super(key: key);

  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool logActive = false;
  TextEditingController controller = TextEditingController();
  late String username;
  bool showPassword = false;
  Icon passwordVisibilityStyle = const Icon(Icons.visibility_outlined,
      color: Color(0xffCED7DC), size: 25.0);
  Icon passwordCheckSuffix = const Icon(null);
  Widget? bottomSheet = null;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final bool logActive = controller.text.isNotEmpty;
      setState(() {
        this.logActive = logActive;
        passwordCheckSuffix = logActive
            ? const Icon(
                Icons.check_circle_outline_sharp,
                size: 25.0,
                color: Color(0xFF2DB169),
              )
            : const Icon(null);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void changePasswordVisibilityIcon(bool isShown) {
    setState(() {
      showPassword = !showPassword;
      if (isShown) {
        passwordVisibilityStyle = const Icon(Icons.visibility_rounded,
            color: Color(0xffCED7DC), size: 25.0);
      } else {
        passwordVisibilityStyle = const Icon(Icons.visibility_rounded,
            color: Color(0XFF3993D0), size: 25.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double imageMultiplier;
    username = ModalRoute.of(context)!.settings.arguments as String;
    return BlocConsumer<UserManagementBloc, UserManagementStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            try {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  PreHomePage.route,
                      (Route<dynamic> route) => false);
            } on Exception catch (e) {
              context
                  .read<UserManagementBloc>()
                  .add(StartEvent());
            }
          } else if (state is LoginFailureState) {
            setState(() {
              bottomSheet =
                  _buildBottomSheet(context, state);
            });
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Container(
              color: Colors.lightBlue,
              child: SpinKitRing(
                lineWidth: 6.0,
                size: 70.0,
                color: Colors.white,
              ),
            );
          } else {
            return GestureDetector(
              //to dismiss the snackbar on touch
              onTap: () {
                setState(() {
                  bottomSheet = null;
                });
              },
              child: OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  imageMultiplier = 1;
                } else {
                  imageMultiplier = 1.8;
                }
                return Container(
                  color: Colors.white,
                  child: SafeArea(
                      child: Scaffold(
                    appBar: generalAppBar(context, imageMultiplier),
                    bottomSheet: bottomSheet,
                    body: BlocListener<InternetCubit, InternetState>(
                      listenWhen: (previousState, currentState) =>
                          previousState != currentState,
                      listener: (context, state) =>
                          networkListner(context, state),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Enter your password",
                              style: dispTextStyle,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextField(
                              enabled: false,
                              showCursor: true,
                              cursorHeight: 25.0,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: username,
                                hintStyle: const TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.only(bottom: 6.0),
                              ),
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            TextField(
                              showCursor: true,
                              cursorHeight: 25.0,
                              textAlign: TextAlign.left,
                              controller: controller,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: const TextStyle(fontSize: 18.0),
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 6.0),
                                  suffixIconConstraints: const BoxConstraints(
                                      minWidth: 0, minHeight: 0),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: passwordVisibilityStyle,
                                        onTap: () =>
                                            changePasswordVisibilityIcon(
                                                showPassword),
                                      ),
                                      if (passwordCheckSuffix.icon != null)
                                        passwordCheckSuffix, // check that the icon suffix is not set to null
                                    ],
                                  )),
                              obscureText: !showPassword,
                              autocorrect: false,
                              enableSuggestions: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Transform.translate(
                      offset: Offset(
                          0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
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
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 12.0,
                                  top: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ForgetPassword.route);
                                    },
                                    child: const Text("Forget Password?"),
                                    style: outlinedButtonsStyle,
                                  ),
                                  ElevatedButton(
                                    onPressed: logActive
                                        ? () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            String password = controller.text;
                                            context.read<UserManagementBloc>().add(
                                                LoginButtonPressed(
                                                    username: username,
                                                    password: password));
                                          }
                                        : null,
                                    child: const Text("Log in"),
                                    style: elevatedButtonsStyle,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                );
              }),
            );
          }
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

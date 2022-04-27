import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_bloc.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_bloc.dart';
import 'package:twitter_flutter/blocs/loginStates/login_bloc.dart';
import 'package:twitter_flutter/blocs/loginStates/login_states.dart';
import 'package:twitter_flutter/repositories/authentication/auth_repository.dart';
import 'package:twitter_flutter/screens/profile/pre_edit_profile.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/authentication_requests.dart';
import 'package:twitter_flutter/utils/Web%20Services/edit_profile/update_password_request.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/starting_page.dart';
import 'package:twitter_flutter/screens/authentication/login_password.dart';
import 'package:twitter_flutter/screens/authentication/login_username.dart';
import 'package:twitter_flutter/screens/create_account/create_account_1.dart';
import 'package:twitter_flutter/screens/create_account/create_account_3.dart';
import 'package:twitter_flutter/screens/create_account/create_account_2.dart';
import 'package:twitter_flutter/screens/create_account/create_account_4.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';
import 'package:twitter_flutter/screens/profile_management/settings_and_privacy.dart';
import 'package:twitter_flutter/screens/profile_management/your_account.dart';
import 'package:twitter_flutter/screens/profile/profile.dart';
import 'package:twitter_flutter/screens/profile/edit_profile.dart';
import 'package:twitter_flutter/screens/profile_management/change_password.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';
import 'package:twitter_flutter/screens/create_account/VerificationCode.dart';
import 'package:twitter_flutter/utils/Web Services/authentication/authentication_requests.dart';
import 'blocs/UpdatePasswordStates/updatepassword_bloc.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/edit_profile_request.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart';
import 'models/objects/user.dart';

void main() {
  // To set the status bar to be transparent and text in status bar to be dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark),
  );
  runApp(
      /*DevicePreview(
        enabled: true,
        tools: const [...DevicePreview.defaultTools],
        builder: (context) => */
      Twitter() //),
      );
}

class Twitter extends StatefulWidget {
  Twitter({Key? key}) : super(key: key);

  @override
  State<Twitter> createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
  final EditProfileBloc editProfileBloc =
      EditProfileBloc(editProfileRequests: EditProfileRequests());
  final InternetCubit internetCubit = InternetCubit(Connectivity());
  final LoginBloc loginBloc = LoginBloc(
      authRepository: AuthRepository(authReq: AuthenticationRequests()));
  final UpdatePasswordBloc updatePasswordBloc =
      UpdatePasswordBloc(updateapasswordrequests: UpdatePasswordRequests());
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: loginBloc),
        BlocProvider.value(value: updatePasswordBloc),
        BlocProvider.value(value: internetCubit),
        BlocProvider.value(value: editProfileBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: generalTheme,
        useInheritedMediaQuery: true,
        initialRoute: '/',
        routes: {
          // When navigating to the starting page
          StartingPage.route: (context) => const StartingPage(),

          LoginUsername.route: (context) => const LoginUsername(),

          LoginPassword.route: (context) => const LoginPassword(),

          HomePage.route: (context) => const HomePage(),

          CreateAccount1.route: (context) => const CreateAccount1(),

          CreateAccount2.route: (context) => const CreateAccount2(),

          CreateAccount3.route: (context) => const CreateAccount3(),

          CreateAccount4.route: (context) => const CreateAccount4(),

          YourAccount.route: (context) => const YourAccount(),

          Settings.route: (context) => const Settings(),

          TermsOfService.route: (context) => const TermsOfService(),

          UserProfile.route: (context) => const UserProfile(),

          PreEditProfile.route: (context) => const PreEditProfile(),

          ChangePassword.route: (context) => const ChangePassword(),
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    internetCubit.close();
    loginBloc.close();
    updatePasswordBloc.close();
    editProfileBloc.close();
    super.dispose();
  }
}

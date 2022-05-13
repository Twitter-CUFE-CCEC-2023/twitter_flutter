import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_bloc.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/repositories/user_management_repository.dart';
import 'package:twitter_flutter/screens/authentication/forget_password2.dart';
import 'package:twitter_flutter/screens/profile/followers.dart';
import 'package:twitter_flutter/screens/profile/following.dart';
import 'package:twitter_flutter/screens/profile/pre_edit_profile.dart';
import 'package:twitter_flutter/utils/Web%20Services/user_management_requests.dart';
import 'package:twitter_flutter/utils/Web%20Services/edit_profile/edit_profile_request.dart';
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
import 'package:twitter_flutter/repositories/profile_management/profile_repository.dart';
import 'package:twitter_flutter/screens/profile_management/account_information.dart';
import 'package:twitter_flutter/screens/profile_management/pre_user_name.dart';
import 'package:twitter_flutter/screens/profile_management/change_email.dart';
import 'package:twitter_flutter/screens/profile_management/change_phone.dart';
import 'package:twitter_flutter/screens/profile_management/change_country.dart';
import 'package:twitter_flutter/screens/authentication/forget_password1.dart';
import 'package:twitter_flutter/screens/authentication/forget_password2.dart';
import 'package:twitter_flutter/screens/authentication/forget_password3.dart';
import 'package:twitter_flutter/screens/profile/followers.dart';
import 'package:twitter_flutter/screens/profile_management/change_country2.dart';
import 'package:twitter_flutter/screens/profile_management/verify_password.dart';
import 'package:twitter_flutter/screens/profile_management/verify_password2.dart';


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
      EditProfileBloc(profileRepository: ProfileRepository(profileReq: EditProfileRequests()));
  final InternetCubit internetCubit = InternetCubit(Connectivity());
  final UserManagementBloc userManagementBloc = UserManagementBloc(
      userManagementRepository: UserManagementRepository(userManagementRequests: UserManagementRequests()));
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userManagementBloc),
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

          ForgetPassword.route: (context) => const ForgetPassword(),

          ForgetPassword2.route: (context) => const ForgetPassword2(),

          ForgetPassword3.route: (context) => const ForgetPassword3(),

          HomePage.route: (context) => const HomePage(),

          CreateAccount1.route: (context) => const CreateAccount1(),

          CreateAccount2.route: (context) => const CreateAccount2(),

          CreateAccount3.route: (context) => const CreateAccount3(),

          CreateAccount4.route: (context) => const CreateAccount4(),

          YourAccount.route: (context) => const YourAccount(),

          Settings.route: (context) => const Settings(),

          Account.route: (context) => const Account(),

          PreUsername.route: (context) => const PreUsername(),

          ChangeEmail.route: (context) => const ChangeEmail(),

          VerifyPassword.route: (context) => const VerifyPassword(),

          VerifyPassword2.route: (context) => const VerifyPassword2(),

          ChangePhone.route: (context) => const ChangePhone(),

          ChangeCountry.route: (context) => const ChangeCountry(),

          ChangeCountry2.route: (context) => const ChangeCountry2(),

          TermsOfService.route: (context) => const TermsOfService(),

          UserProfile.route: (context) => const UserProfile(),

          Following.route: (context) => const Following(),

          Followers.route: (context) => const Followers(),

          PreEditProfile.route: (context) => const PreEditProfile(),

          ChangePassword.route: (context) => const ChangePassword(),

          VerificationCode.route : (context) => const VerificationCode()
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    internetCubit.close();
    userManagementBloc.close();
    editProfileBloc.close();
    super.dispose();
  }
}

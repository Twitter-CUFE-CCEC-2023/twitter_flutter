import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/repositories/tweets_management_repository.dart';
import 'package:twitter_flutter/repositories/user_management_repository.dart';
import 'package:twitter_flutter/screens/profile/pre_edit_profile.dart';
import 'package:twitter_flutter/screens/profile/timeline_util_screens/postTweet.dart';
import 'package:twitter_flutter/utils/Web%20Services/tweets_management_requests.dart';
import 'package:twitter_flutter/utils/Web%20Services/user_management_requests.dart';
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
import 'package:twitter_flutter/screens/profile_management/change_password.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';
import 'package:twitter_flutter/screens/create_account/VerificationCode.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twitter_flutter/blocs/profileTabs/liked_tweets_tab_cubit.dart';
import 'package:twitter_flutter/blocs/tweetsManagement/tweets_managment_bloc.dart';
import 'package:twitter_flutter/models/hive models/logged_user.dart';
import 'package:twitter_flutter/blocs/profileTabs/tweets_tab_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LoggedUserAdapter());

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
  final InternetCubit internetCubit = InternetCubit(Connectivity());
  final UserManagementBloc userManagementBloc = UserManagementBloc(
      userManagementRepository: UserManagementRepository(
          userManagementRequests: UserManagementRequests()));
  final TweetsManagementBloc tweetsManagementBloc = TweetsManagementBloc(
      tweetsManagementRepository: TweetsManagementRepository(
          tweetsManagementRequests: TweetsManagementRequests()));
  final TweetsTabCubit tweetsTabCubit = TweetsTabCubit();
  final LikedTweetsTabCubit likedTweetsTabCubit = LikedTweetsTabCubit();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userManagementBloc),
        BlocProvider.value(value: internetCubit),
        BlocProvider.value(value: tweetsManagementBloc),
        BlocProvider.value(value: tweetsTabCubit),
        BlocProvider.value(value: likedTweetsTabCubit),
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

          VerificationCode.route: (context) => const VerificationCode(),

          PostTweet.route : (context) => const PostTweet(),
        },
      ),
    );
  }

  @override
  void dispose() {
    internetCubit.close();
    userManagementBloc.close();
    tweetsManagementBloc.close();
    tweetsTabCubit.close();
    likedTweetsTabCubit.close();
    super.dispose();
  }
}

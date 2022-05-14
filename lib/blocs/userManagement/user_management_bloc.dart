import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/models/hive%20models/logged_user.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/repositories/user_management_repository.dart';
import 'package:twitter_flutter/utils/local_db/boxes.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvents, UserManagementStates> {
  late UserModel userdata;
  late String access_token;
  late int turn = 0;
  UserManagementRepository userManagementRepository;
  UserManagementBloc({required this.userManagementRepository})
      : super(InitState()) {
    on<StartEvent>(_onStartEvent);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SignupButtonPressed>(_onSignUpButtonPressed);
    on<VerificationButtonPressed>(_onVerificationButtonPressed);
    on<UpdatePasswordButtonPressed>(_onUpdatePasswordButtonPressed);
    on<EditProfileButtonPressed>(_onEditProfileButtonPressed);
    on<LoadUserProfile>(_onLoadUserProfileEvent);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onStartEvent(
      StartEvent event, Emitter<UserManagementStates> emit) async {
    emit(LoadingState());
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? access_token = prefs.getString('access_token');
      // String? username = prefs.getString('username');

      var box = await Boxes.openUserBox();
      LoggedUser? loggedUser = box.get('loggedUser');
      box.close();
      print('loggedUser: $loggedUser');
      if (loggedUser != null) {
        access_token = loggedUser.access_token;
        var data = await userManagementRepository.getUserProfile(
            username: loggedUser.username, access_token: access_token);
        userdata = data;
        emit(LoginSuccessState(data));
      } else {
        emit(LoginFailureState(errorMessage: "No user logged in"));
      }
    } on Exception catch (e) {
      emit(LoginFailureState(
          errorMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<UserManagementStates> emit) async {
    emit(LoadingState());
    try {
      var data = await userManagementRepository.login(
          username: event.username, password: event.password);
      LoggedUser loggedUser = LoggedUser()
        ..username = data.user.username
        ..access_token = data.access_token
        ..token_expiration_date = data.token_expiration_date.toIso8601String();
      var box = await Boxes.openUserBox();
      box.put("user",loggedUser);
      print("login event");
      print(box.get("user")?.username);
      box.close();

      //var pref = await SharedPreferences.getInstance();
      // pref.setString("access_token", data.access_token);
      // pref.setString("token_expiration_date",data.token_expiration_date.toIso8601String());
      // pref.setString("username", data.user.username);

      userdata = data.user;
      access_token = data.access_token;
      emit(LoginSuccessState(data.user));
    } on Exception catch (e) {
      emit(LoginFailureState(
          errorMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onSignUpButtonPressed(
      SignupButtonPressed event, Emitter<UserManagementStates> emit) async {
    emit(LoadingState());
    try {
      var data = await userManagementRepository.signUp(
        username: event.username,
        email: event.email,
        password: event.password,
        date_of_birth: event.date,
        gender: event.gender,
        name: event.name,
      );
      userdata = data.user;
      emit(SignupSuccessState(userdata: data.user));
    } on Exception catch (e) {
      emit(SignupFailureState(
          errorMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  void _onVerificationButtonPressed(VerificationButtonPressed event,
      Emitter<UserManagementStates> emit) async {
    emit(LoadingState());
    try {
      var data = await userManagementRepository.verify(
          verificationCode: event.verificationCode,email_or_username: userdata.username);
      emit(VerificationSuccessState());
    } on Exception catch (e) {
      emit(VerificationFailureState(
          errorMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  void _onUpdatePasswordButtonPressed(UpdatePasswordButtonPressed event,
      Emitter<UserManagementStates> emit) async {
    emit(LoadingState());
    try {
      var data = await userManagementRepository.updatePassword(
          Old_Password: event.oldpassword, New_Password: event.newpassword);
      emit(UpdatePasswordSuccessState(succesMessage: data));
    } on Exception catch (e) {
      emit(UpdatePasswordFailureState(
          failureMessage: e.toString().replaceAll("Exception: ", "")));
    }
  }

  void _onEditProfileButtonPressed(EditProfileButtonPressed event,
      Emitter<UserManagementStates> emit) async {
    emit(LoadingState());
    try {
      var data = await userManagementRepository.editProfile(
          // name: event.name,
          // location: event.location,
          // website: event.website,
          // bio: event.bio,
          // month_day_access: event.month_day_access,
          // year_access: event.year_access,
          // birth_date: event.birth_date
          );
      //userdata = data.user;
      //emit(EditProfileSuccessState(data.user));
    } on Exception catch (e) {
      emit(EditProfileFailureState(
          failureMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  void _onLoadUserProfileEvent(
      LoadUserProfile event, Emitter<UserManagementStates> emitter) async {
    emit(LoadingState());
    try {
      var data = await userManagementRepository.getUserProfile(
          username: event.username, access_token: event.access_token);
      userdata = data;
      emit(LoginSuccessState(data));
    } on Exception catch (e) {
      emit(LoginFailureState(
          errorMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<UserManagementStates> emitter) async {
    emit(LoadingState());
    try {
      //var pref = await SharedPreferences.getInstance();
      // pref.remove("access_token");
      // pref.remove("username");
      // pref.remove("token_expiration_date");
      turn =0;
      var box = await Boxes.openUserBox();
      print("logout event");
      print(box.get("user")?.username);
      box.delete("user");
      box.close();
      emit(LogoutSuccessState());
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

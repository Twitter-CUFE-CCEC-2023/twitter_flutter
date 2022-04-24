import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/blocs/loginStates/login_events.dart';
import 'package:twitter_flutter/blocs/loginStates/login_states.dart';
import 'package:twitter_flutter/repositories/authentication/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginInitState()) {
    on<StartEvent>((event, emit) => emit(LoginInitState()));
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SignupButtonPressed>(_onSignUpButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());
    try {
      var data = await authRepository.login(
          username: event.username, password: event.password);
      var pref = await SharedPreferences.getInstance();
      pref.setString("access_token", data.access_token);
      pref.setString("token_expiration_date",
          data.token_expiration_date.toIso8601String());
      emit(LoginSuccessState(data.user));
    } on Exception catch (e) {
      emit(LoginFailureState(
          errorMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  void _onSignUpButtonPressed(
      SignupButtonPressed event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());
    try {
      var data = await authRepository.signUp(
        username: event.username,
        email: event.email,
        password: event.password,
        date_of_birth: event.date,
        gender: event.gender,
        name: event.name,
      );
      var pref = await SharedPreferences.getInstance();
      pref.setString("access_token", data.access_token);
      pref.setString("token_expiration_date",
          data.token_expiration_date.toIso8601String());
      emit(LoginSuccessState(data.user));
    } on Exception catch (e) {
      emit(SignupFailureState(
          errorMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

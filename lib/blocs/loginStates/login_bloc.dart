import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/blocs/loginStates/login_events.dart';
import 'package:twitter_flutter/blocs/loginStates/login_states.dart';
import 'package:twitter_flutter/repositories/authentication/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  late AuthRepository authRepository;
  late StreamSubscription streamSubscription;
  LoginBloc() : super(LoginInitState()) {
    streamSubscription = stream.listen((event) {
      if(event is LoginLoadingState)
        {
          Future.delayed(Duration(seconds: 10)).then((_) => {
            emit(LoginInitState())
          });
        }
    });
    on<StartEvent>((event, emit) => emit(LoginInitState()));
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }


  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());
    var pref= await SharedPreferences.getInstance();
    authRepository = AuthRepository(event.username, event.password);
    try {
      var data = await authRepository.login();
      pref.setString("access_token",data.access_token);
      pref.setString("token_expiration_date", data.token_expiration_date.toIso8601String());
      emit(LoginSuccessState(data.user));
    } on Exception catch (e) {
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

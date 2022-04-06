import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:twitter_flutter/blocs/loginStates/login_bloc.dart';
import 'package:twitter_flutter/blocs/loginStates/login_states.dart';
import 'package:twitter_flutter/blocs/loginStates/login_events.dart';

void main() {
  group("Login Bloc Tests", () {
    late LoginBloc loginBloc;
    setUp(() {
      loginBloc = LoginBloc();
    });

    tearDown(() {
      loginBloc.close();
    });

    test("Initial State is <LoginInitState()>", () {
      expect(loginBloc.state, LoginInitState());
    });

    blocTest("No state is emitted when no event is added",
        build: () => loginBloc, expect: () => []);

    //Needs to mock the repo to enforce the UNT principle
    //Implentation of Bloc needs to be changed e.g. provide the repo in the constructor
    //to be able to mock it.
    blocTest<LoginBloc, LoginStates>(
        "LoginLoading State is fired when Login button is pressed",
        build: () => loginBloc,
        act: (bloc) => bloc
            .add(LoginButtonPressed(username: "ahmedhussien783@gmail.com", password: "123456")),
        expect: () => [LoginLoadingState()]);


  });


}

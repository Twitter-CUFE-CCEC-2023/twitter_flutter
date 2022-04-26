import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_bloc.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_events.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_states.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/models/profile_management/update_password_model.dart';
import 'package:twitter_flutter/repositories/profile_management/update_password_repository.dart';
import 'package:twitter_flutter/repositories/profile_management/update_password_repository.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart';
import 'updatepassword_bloc_test.mocks.dart';

@GenerateMocks([UpdatePasswordRepository,UpdatePasswordRequests])
void main() {
  late UpdatePasswordBloc updatePasswordBloc;
  late UpdatePasswordRepository mockUpdatePasswordRepository;
  setUp(() {
    mockUpdatePasswordRepository = MockUpdatePasswordRepository();
    //stub 1
    when(mockUpdatePasswordRepository.updatePassword(
        oldPassword: " ", newPassword: " ")).thenAnswer((_) async =>
        UserPasswordModel.fromJsonUpdatePassword(<String, dynamic>{
          'message': '',
          'token_expiration_date': '2022-04-23T15:48:54.813Z',
          'access_token': '',
          'user': {
            "_id": "",
            "name": "",
            "username": "",
            "email": "",
            "profile_image_url": "",
            "cover_image_url": "",
            "bio": "",
            "website": "",
            "location": "",
            "created_at": "2022-04-23T15:48:54.813Z",
            "isVerified": true,
            "followers_count": 1,
            "following_count": 1,
            "tweets_count": 1,
            "likes_count": 1,
            "isBanned": true,
            "birth_date": "2022-04-23T15:48:54.813Z"
          }
        }));

    //stub 2
    when(mockUpdatePasswordRepository.updatePassword(
        oldPassword: "err", newPassword: " ")).thenThrow(
        Exception("wrong Credentials"));

    updatePasswordBloc = UpdatePasswordBloc(
        updatePasswordRepository: mockUpdatePasswordRepository);
  });

  tearDown(() {
    updatePasswordBloc.close();
  });

  test("Initial State is <LoginInitState()>", () {
    expect(updatePasswordBloc.state, UpdatePasswordInitState());
  });


  blocTest("No state is emitted when no event is added",
      build: () => updatePasswordBloc, expect: () => []);



  blocTest<UpdatePasswordBloc,UpdatePasswordStates>("UpdatePassword Success State is Emitted after Loading when a success response is returned from UpdatePassword Event", build: ()=>updatePasswordBloc,
      act: (bloc)=>bloc.add(UpdatePasswordButtonPressed(oldpassword:" " ,newpassword: " ")),
      expect: ()=>[UpdatePasswordLoadingState(),UpdatePasswordSuccessState(succesMessage: 'Password has been updated successfully')]
  );

  blocTest<UpdatePasswordBloc,UpdatePasswordStates>("Login Failure State is Emitted when an exception is thrown due to wrong response",build: ()=>updatePasswordBloc,
      act: (bloc)=>bloc.add(UpdatePasswordButtonPressed(oldpassword: "err",newpassword: " ")),
      expect: ()=>[UpdatePasswordLoadingState(),UpdatePasswordFailureState(failureMessage: " wrong Credentials")]
  );}
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_bloc.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_events.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_states.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart';
import 'updatepassword_bloc_test.mocks.dart';

@GenerateMocks([UpdatePasswordRequests])
void main() {
  late UpdatePasswordBloc updatePasswordBloc;
  late MockUpdatePasswordRequests mockUpdatePasswordRequests;

  setUp(() {
    mockUpdatePasswordRequests = MockUpdatePasswordRequests();
    //Stub 1
    when(mockUpdatePasswordRequests.UpadtePassword(
            Old_Password: " ", New_Password: " "))
        .thenAnswer((_) async {
      return "Success";
    });

    //Stub 2
    when(mockUpdatePasswordRequests.UpadtePassword(
            Old_Password: "err", New_Password: " "))
        .thenThrow(Exception("Failure"));
    updatePasswordBloc =
        UpdatePasswordBloc(updateapasswordrequests: mockUpdatePasswordRequests);
  });

  tearDown(() {
    updatePasswordBloc.close();
  });

  blocTest<UpdatePasswordBloc, UpdatePasswordStates>(
      "Success Message is returned upon password update successfully",
      build: () => updatePasswordBloc,
      act: (bloc) => bloc
          .add(UpdatePasswordButtonPressed(oldpassword: " ", newpassword: " ")),
      expect: () => [
            UpdatePasswordLoadingState(),
            UpdatePasswordSuccessState(succesMessage: "Success")
          ]);

  blocTest<UpdatePasswordBloc, UpdatePasswordStates>(
      "Success Message is returned upon password update successfully",
      build: () => updatePasswordBloc,
      act: (bloc) => bloc.add(
          UpdatePasswordButtonPressed(oldpassword: "err", newpassword: " ")),
      expect: () => [
            UpdatePasswordLoadingState(),
            UpdatePasswordFailureState(failureMessage: "Failure")
          ]);
}

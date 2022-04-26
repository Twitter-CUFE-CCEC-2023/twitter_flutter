import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_events.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_states.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart';


class UpdatePasswordBloc extends Bloc<UpdatePasswordEvents, UpdatePasswordStates> {
  UpdatePasswordRequests updateapasswordrequests;
  UpdatePasswordBloc({required this.updateapasswordrequests}) : super(UpdatePasswordInitState()) {
    on<StartEvent>((event, emit) => emit(UpdatePasswordInitState()));
    on<UpdatePasswordButtonPressed>(_onUpdatePasswordButtonPressed);
  }


  void _onUpdatePasswordButtonPressed(
      UpdatePasswordButtonPressed event, Emitter<UpdatePasswordStates> emit) async {
    emit(UpdatePasswordLoadingState());
    try {
      var data = await updateapasswordrequests.UpdatePassword(Old_Password:event.oldpassword,New_Password:event.newpassword);
      emit(UpdatePasswordSuccessState(succesMessage: data));
    } on Exception catch (e) {
      emit(UpdatePasswordFailureState(failureMessage: e.toString().replaceAll("Exception: ","")));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

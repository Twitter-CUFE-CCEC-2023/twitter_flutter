import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_events.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_states.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/edit_profile_request.dart';
import 'package:twitter_flutter/models/profile_management/Edit_profile_model.dart';
import 'package:twitter_flutter/repositories/profile_management/profile_repository.dart';


  class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
    EditProfileRequests editProfileRequests;
  EditProfileBloc({required this.editProfileRequests}) : super(EditProfileInitState()) {
    on<StartEvent>((event, emit) => emit(EditProfileInitState()));
    on<EditProfileButtonPressed>(_onEditProfileButtonPressed);
  }


  void _onEditProfileButtonPressed(
      EditProfileButtonPressed event, Emitter<EditProfileStates> emit) async {
    emit(EditProfileLoadingState());
    try {
      var data = await editProfileRequests.EditProfile(
          Name: event.name,
          Location: event.location,
          Website: event.website,
          Bio: event.bio,
          Month_Day_Access: event.month_day_access,
          Year_Access: event.year_access,
          Birth_Date: event.birth_date);
      var pref = await SharedPreferences.getInstance();
      emit(EditProfileSuccessState(jsonDecode(data)['user']));
    } on Exception catch (e) {
      emit(EditProfileFailureState(
          failureMessage: e.toString().replaceAll("Exception:", "")));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

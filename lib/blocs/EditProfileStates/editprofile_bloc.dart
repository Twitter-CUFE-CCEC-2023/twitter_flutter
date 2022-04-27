import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_events.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_states.dart';
import 'package:twitter_flutter/repositories/profile_management/profile_repository.dart';


  class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
    ProfileRepository profileRepository;
  EditProfileBloc({required this.profileRepository}) : super(EditProfileInitState()) {
    on<StartEvent>((event, emit) => emit(EditProfileInitState()));
    on<EditProfileButtonPressed>(_onEditProfileButtonPressed);
  }


  void _onEditProfileButtonPressed(
      EditProfileButtonPressed event, Emitter<EditProfileStates> emit) async {
    emit(EditProfileLoadingState());
    try {
      var data = await profileRepository.editProfile(
          name: event.name,
          location: event.location,
          website: event.website,
          bio: event.bio,
          month_day_access: event.month_day_access,
          year_access: event.year_access,
          birth_date: event.birth_date);
      emit(EditProfileSuccessState((data.user)));
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

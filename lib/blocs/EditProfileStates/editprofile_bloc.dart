import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_events.dart';
import 'package:twitter_flutter/blocs/EditProfileStates/editprofile_states.dart';
import 'package:twitter_flutter/repositories/profile_management/profile_repository.dart';


  class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
    ProfileRepository profileRepository;
  EditProfileBloc({required this.profileRepository}) : super(EditProfileInitState()) {
    on<StartEvent>((event, emit) => emit(EditProfileInitState()));
  }




  @override
  Future<void> close() {
    return super.close();
  }
}

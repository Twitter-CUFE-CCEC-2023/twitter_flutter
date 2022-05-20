import 'package:equatable/equatable.dart';

abstract class UserManagementEvents extends Equatable {}

class StartEvent extends UserManagementEvents {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends UserManagementEvents {
  final String username;
  final String password;
  static const bool rememberMe = true;
  LoginButtonPressed({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}

class VerificationButtonPressed extends UserManagementEvents {
  final int verificationCode;
  VerificationButtonPressed({required this.verificationCode});
  @override
  List<Object?> get props => [verificationCode];
}

class SignupButtonPressed extends UserManagementEvents {
  final String name, password, email, date, username, gender;
  SignupButtonPressed(
      {required this.name,
      required this.password,
      required this.email,
      required this.username,
      required this.gender,
      required this.date});
  @override
  List<Object?> get props => [name, password, email, date];
}

class UpdatePasswordButtonPressed extends UserManagementEvents {
  final String oldpassword;
  final String newpassword;
  UpdatePasswordButtonPressed(
      {required this.oldpassword, required this.newpassword});
  @override
  List<Object?> get props => [oldpassword, newpassword];
}

class EditProfileButtonPressed extends UserManagementEvents {
  final String name,
      location,
      website,
      bio,
      birth_date,
      month_day_access,
      year_access;
  EditProfileButtonPressed({
    required this.name,
    required this.location,
    required this.website,
    required this.bio,
    required this.birth_date,
    required this.month_day_access,
    required this.year_access,
  });
  @override
  List<Object?> get props =>
      [name, location, website, bio, birth_date, month_day_access, year_access];
}

class LoadUserProfile extends UserManagementEvents {
  String username;
  String access_token;
  LoadUserProfile({required this.username, required this.access_token});
  @override
  List<Object?> get props => [username, access_token];
}

class LogoutButtonPressed extends UserManagementEvents {
  @override
  List<Object?> get props => [];
}

class FollowButtonPressed extends UserManagementEvents {
  final String access_token;
  final String username;
  final bool notify = true;
  FollowButtonPressed({required this.access_token, required this.username,});
  @override
  List<Object?> get props => [username, access_token];
}



import 'dart:convert';

import 'package:twitter_flutter/models/profile_management/update_password_model.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart';

class UpdatePasswordRepository {
  late UpdatePasswordRequests updatePasswordReq;

  UpdatePasswordRepository({required this.updatePasswordReq});

  Future<UserPasswordModel> updatePassword({oldPassword, newPassword}) async {
    try {
      String updatePassData =
      await updatePasswordReq.UpadtePassword(Old_Password: oldPassword, New_Password: newPassword);
      return UserPasswordModel.fromJsonUpdatePassword(jsonDecode(updatePassData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }}

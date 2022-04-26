// Mocks generated by Mockito 5.1.0 from annotations
// in twitter_flutter/test/blocs/LoginStates/login_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import'package:twitter_flutter/models/profile_management/update_password_model.dart'
as _i3;
import 'package:twitter_flutter/repositories/profile_management/update_password_repository.dart'
as _i4;
import'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart'
as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUpdatePasswordRequests_0 extends _i1.Fake
    implements _i2.UpdatePasswordRequests {}

class _FakeUserPasswordModel_1 extends _i1.Fake
    implements _i3.UserPasswordModel {}

/// A class which mocks [MockUpdatePasswordRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdatePasswordRepository extends _i1.Mock implements _i4.UpdatePasswordRepository {
  MockUpdatePasswordRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UpdatePasswordRequests get updatePasswordReq =>
      (super.noSuchMethod(Invocation.getter(#updatePasswordReq),
          returnValue: _FakeUpdatePasswordRequests_0())
      as _i2.UpdatePasswordRequests);

  @override
  set updatePasswordReq(_i2.UpdatePasswordRequests? _updatePasswordReq) =>
      super.noSuchMethod(Invocation.setter(#updatePasswordReq, _updatePasswordReq),
          returnValueForMissingStub: null);

  @override
  _i5.Future<_i3.UserPasswordModel> updatePassword(
      {dynamic oldPassword, dynamic newPassword}) =>
      (super.noSuchMethod(
          Invocation.method(
              #updatepassword, [], {#oldpassword: oldPassword, #newpassword: newPassword}),
          returnValue: Future<_i3.UserPasswordModel>.value(
              _FakeUserPasswordModel_1()))
      as _i5.Future<_i3.UserPasswordModel>);
}

/// A class which mocks [_i2.UpdatePasswordRequests].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdatePasswordRequests extends _i1.Mock
    implements _i2.UpdatePasswordRequests {
  MockUpdatePasswordRequests() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> updatePassword({dynamic oldPassword, dynamic newPassword}) =>
      (super.noSuchMethod(
          Invocation.method(
              #UpdatePassword, [], {#oldpassword: oldPassword, #newpassword: newPassword}),
          returnValue: Future<String>.value('')) as _i5.Future<String>);

}

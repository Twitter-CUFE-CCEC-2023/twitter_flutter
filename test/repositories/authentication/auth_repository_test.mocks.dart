// Mocks generated by Mockito 5.1.0 from annotations
// in twitter_flutter/test/repositories/authentication/auth_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:twitter_flutter/utils/Web%20Services/user_management_requests.dart'
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

/// A class which mocks [UserManagementRequests].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserManagementRequests extends _i1.Mock
    implements _i2.UserManagementRequests {
  MockUserManagementRequests() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> login({dynamic username, dynamic password}) =>
      (super.noSuchMethod(
          Invocation.method(
              #login, [], {#username: username, #password: password}),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
  @override
  _i3.Future<String> signUp(
          {dynamic name,
          dynamic email,
          dynamic username,
          dynamic gender,
          dynamic password,
          dynamic birth_date}) =>
      (super.noSuchMethod(
          Invocation.method(#signUp, [], {
            #name: name,
            #email: email,
            #username: username,
            #gender: gender,
            #password: password,
            #birth_date: birth_date
          }),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
  @override
  _i3.Future<String> Verification(
          {dynamic email_or_username, dynamic verificationCode}) =>
      (super.noSuchMethod(
          Invocation.method(#Verification, [], {
            #email_or_username: email_or_username,
            #verificationCode: verificationCode
          }),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
  @override
  _i3.Future<String> UpdatePassword(
          {dynamic New_Password, dynamic Old_Password}) =>
      (super.noSuchMethod(
          Invocation.method(#UpdatePassword, [],
              {#New_Password: New_Password, #Old_Password: Old_Password}),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
  @override
  _i3.Future<String> editProfile(
          {dynamic Name,
          dynamic Location,
          dynamic Website,
          dynamic Bio,
          dynamic Month_Day_Access,
          dynamic Year_Access,
          dynamic Birth_Date}) =>
      (super.noSuchMethod(
          Invocation.method(#editProfile, [], {
            #Name: Name,
            #Location: Location,
            #Website: Website,
            #Bio: Bio,
            #Month_Day_Access: Month_Day_Access,
            #Year_Access: Year_Access,
            #Birth_Date: Birth_Date
          }),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
  @override
  _i3.Future<String> getUserProfile({String? access_token, String? username}) =>
      (super.noSuchMethod(
          Invocation.method(#getUserProfile, [],
              {#access_token: access_token, #username: username}),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
}

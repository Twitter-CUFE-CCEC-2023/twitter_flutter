// import 'package:test/test.dart';
// import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
// import 'package:twitter_flutter/repositories/user_management_repository.dart';
// import 'package:twitter_flutter/utils/Web%20Services/user_management_requests.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'auth_repository_test.mocks.dart';
//
// @GenerateMocks([UserManagementRequests])
// void main() {
//   late UserManagementRepository authRepository;
//   late MockAuthenticationRequests mockAuthenticationRequests;
//
//   setUp(() {
//     mockAuthenticationRequests = MockAuthenticationRequests();
//     when(mockAuthenticationRequests.login(username: " ", password: " "))
//         .thenAnswer((_) async {
//       return "{'message': '',token_expiration_date: '2022-04-23T15:48:54.813Z',access_token: '',user : {name: '',username : '' ,email : ''}}";
//     });
//     authRepository = UserManagementRepository(userManagementRequests: mockAuthenticationRequests);
//   });
//
//   // test("ds", () {
//   //   expect(
//   //       authRepository.login(username: " ", password: " "),
//   //       Future.value(UserAuthenticationModel.fromJson(<String, dynamic>{
//   //         'message': '',
//   //         'token_expiration_date': '2022-04-23T15:48:54.813Z',
//   //         'access_token': '',
//   //         'user': {"name": "", "username": "", "email": ""}
//   //       })));
//   // });
// }

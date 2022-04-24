import 'package:test/test.dart';
import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/repositories/authentication/auth_repository.dart';
import 'package:twitter_flutter/utils/Web Services/authentication/authentication_requests.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthenticationRequests])
void main() {
  late AuthRepository authRepository;
  late MockAuthenticationRequests mockAuthenticationRequests;

  setUp(() {
    mockAuthenticationRequests = MockAuthenticationRequests();
    when(mockAuthenticationRequests.Login(username: " ", password: " "))
        .thenAnswer((_) async {
      return "{'message': '',token_expiration_date: '2022-04-23T15:48:54.813Z',access_token: '',user : {name: '',username : '' ,email : ''}}";
    });
    authRepository = AuthRepository(authReq: mockAuthenticationRequests);
  });

  test("ds", () {
    expect(
        authRepository.login(username: " ", password: " "),
        Future.value(UserAuthenticationModel.fromJson(<String, dynamic>{
          'message': '',
          'token_expiration_date': '2022-04-23T15:48:54.813Z',
          'access_token': '',
          'user': {"name": "", "username": "", "email": ""}
        })));
  });
}

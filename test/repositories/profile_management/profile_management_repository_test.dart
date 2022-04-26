import 'package:test/test.dart';
import 'package:twitter_flutter/repositories/profile_management/update_password_repository.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/update_password_request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../blocs/UpdatePasswordStates/updatepassword_bloc_test.mocks.dart';
import 'profile_management_repository_test.mocks.dart';

@GenerateMocks([UpdatePasswordRequests])
void main() {
  late UpdatePasswordRepository updatePasswordRepository;
  late MockUpdatePasswordRequest mockUpdatePasswordRequests;

  setUp(() {
    mockUpdatePasswordRequests = MockUpdatePasswordRequest();
    when(mockUpdatePasswordRequests.UpdatePassword(
        oldPassword: " ", newPassword: " "))
        .thenAnswer((_) async {
      return "{'message': '',token_expiration_date: '2022-04-23T15:48:54.813Z',access_token: '',user : {name: '',username : '' ,email : ''}}";
    });
    updatePasswordRepository =
        UpdatePasswordRepository(updatePasswordReq: mockUpdatePasswordRequests);
  });
}
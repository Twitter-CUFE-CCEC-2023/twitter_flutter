import 'package:test/test.dart';
import 'package:twitter_flutter/screens/create_account/create_account_1.dart';

void main() {
  test('Given valid user email when ValidiateMail called should return true ',
      () {
    const String email = "khaled@gmail.com";
    expect(ValidateEmailOrPhone(email), true);
  });
  test(
      'Given invalid user email when ValidiateMail called should return false ',
      () {
    const String email = "ahmed7778.com";
    expect(ValidateEmailOrPhone(email), false);
  });
}

import 'package:hive/hive.dart';

part 'logged_user.g.dart';

@HiveType(typeId: 1)
class LoggedUser extends HiveObject {
  @HiveField(0)
  late String access_token;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String token_expiration_date;
}


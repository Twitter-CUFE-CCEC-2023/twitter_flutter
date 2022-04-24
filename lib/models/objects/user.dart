import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  late String _id;
  late String name;
  late String username;
  late String email;


  UserModel.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    username = json["username"];
    email = json["email"];
  }

  @override
  List<Object?> get props => [name,username,email,];
}

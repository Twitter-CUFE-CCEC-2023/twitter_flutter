import 'dart:convert';
//import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class UpdatePasswordRequests {

  late final String _token;
  late final String _old_password;
  late final String _new_password;

  Future<String> UpadtePassword({required New_Password,required Old_Password,token}) async {
    var headers = {'Content-Type': 'application/json'};
    // var headers = {'Content-Type': 'application/json','token':token};



    var body = jsonEncode(<String, String>{
      "old_password": Old_Password ?? _old_password,
      "new_password": New_Password ?? _new_password,
    });

    http.Response res = await http.put(
        Uri.parse("$ENDPOINT/auth/update-password"),
        body: body, headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid Password Credentials");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

}
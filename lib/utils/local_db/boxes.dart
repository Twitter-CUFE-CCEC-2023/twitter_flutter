import 'package:hive/hive.dart';
import 'package:twitter_flutter/models/hive models/logged_user.dart';
class Boxes{
  static Future<Box<LoggedUser>> openUserBox() async {
    return   await Hive.openBox('loggedUser');
  }

}
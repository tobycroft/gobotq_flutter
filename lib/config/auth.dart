import 'package:flutter/cupertino.dart';
import 'package:gobotq_flutter/app/login/login.dart';
import 'package:gobotq_flutter/tuuz/storage/storage.dart';
import 'package:gobotq_flutter/tuuz/win/close.dart';

class Auth {
  static Future<bool> Check_login() async {
    bool uid = await Storage.Has("__uid__");
    bool token = await Storage.Has("__token__");
    if (uid && token) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> Check_and_goto_login(BuildContext context) async {
    bool uid = await Storage.Has("__uid__");
    bool token = await Storage.Has("__token__");
    if (uid && token) {
      return true;
    } else {
      Goto_Login(context);
      return false;
    }
  }

  static bool Return_login_check_and_Goto(BuildContext context, Map json) {
    if (json["code"] == -1) {
      Windows.Open(context, Login());
      return false;
    } else {
      return true;
    }
  }

  static bool Return_login_check(BuildContext context, Map json) {
    if (json["code"] == -1) {
      return false;
    } else {
      return true;
    }
  }

  static void Goto_Login(BuildContext context) {
    Windows.Open(context, Login());
  }
}

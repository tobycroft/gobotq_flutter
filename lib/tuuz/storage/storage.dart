import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<String> Get(String key) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    return share.get(key);
  }

  Future<bool> Set(String key, value) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    return share.setString(key, value);
  }

  Future<bool> Clear() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    return share.clear();
  }

  Future<bool> Delete(String key) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    return share.remove(key);
  }

  Future<bool> Has(String key) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    return share.containsKey(key);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;

  UserManager._internal();

  Future<void> setUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    print('usermanager $uid');
  }

  Future<String?> getUID() async {
    print('usermanager uiddd ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}

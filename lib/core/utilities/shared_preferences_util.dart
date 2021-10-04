import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setUserName( userName) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('userName', userName);
  }

  Future<String?> getUserName() async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userName');
  }

}
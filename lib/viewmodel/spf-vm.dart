import 'package:shared_preferences/shared_preferences.dart';

class SP {
  // Save To Key
  static Future save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    print('Saved : ' + key + " Value : " + value);
  }

  // Get Current Token
  static Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }

  // Get Current Others
  static Future getOthers(other) async {
    final prefs = await SharedPreferences.getInstance();
    String x = prefs.getString(other);
    return x;
  }

  // Save To List String
  static Future saveList({String key, List value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
    print('Saved : ' + key + " Value : " + value.toString());
  }

  // Get List String
  static Future getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List x = prefs.getStringList(key);
    return x;
  }
}

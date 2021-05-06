import 'dart:convert';

import 'package:flutterapp/core/server.dart';
import 'package:flutterapp/model/users-m.dart';
import 'package:flutterapp/viewmodel/spf-vm.dart';
import 'package:http/http.dart' as http;

class UsersVM {
  static String url = Server.now;
  static String appControl = 'Lumen-App debugging123';

  static Future getUserAll() async {
    var token = await SP.getToken();
    final response = await http.get(
      url + "users",
      headers: {
        'Access-Control-Request-Headers': appControl,
        'Authorization': 'Render-App ' + token.toString() ?? '-',
      },
    );
    try {
      var data = json.decode(response.body);
      // print(data.toString());
      final List<UsersModel> x = usersModelFromJson(data['data']);
      x.sort((b, a) => a.createdAt.compareTo(b.createdAt));
      return x;
    } catch (e) {}
  }

  static Future store({firstname, lastname, email, username, password}) async {
    var token = await SP.getToken();
    final response = await http.post(url + "auth/buat-akun", headers: {
      'Access-Control-Request-Headers': appControl,
      'Authorization': 'Render-App ' + token.toString() ?? '-',
    }, body: {
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'username': username,
      'password': password,
    });
    try {
      var data = json.decode(response.body);
      return data;
    } catch (e) {}
  }
}

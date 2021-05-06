import 'dart:convert';

import 'package:flutterapp/core/server.dart';
import 'package:flutterapp/viewmodel/spf-vm.dart';
import 'package:http/http.dart' as http;

class AuthVM {
  static String url = Server.now;
  static String appControl = 'Lumen-App debugging123';

  //Check Auth For User
  static Future cekAuth() async {
    var token = await SP.getToken();
    final response = await http.post(
      url + "auth/check-auth",
      headers: {
        'Access-Control-Request-Headers': appControl,
        'Authorization': 'Render-App ' + token.toString() ?? '-',
      },
    );
    try {
      // print(token.toString() ?? '-');
      var res = json.decode(response.body);
      if (response.statusCode == 401) {
        return 'login';
      } else if (response.statusCode == 200) {
        SP.save('nama', res['data']['nama']);
        return res['data']['privileges'];
      }
    } on Exception catch (e) {
      print(e.toString());
      return 'login';
    }
  }

  //Logout For User
  static Future logout() async {
    var token = await SP.getToken();
    final response = await http.post(
      url + "auth/logout",
      headers: {
        'Access-Control-Request-Headers': appControl,
        'Authorization': 'Render-App ' + token.toString() ?? '-',
      },
    );
    try {
      SP.save('token', '-');
      print(response.body.toString());
      return 'login';
    } on Exception catch (e) {
      print(e.toString());
      return 'login';
    }
  }

  //Login Method
  static Future login(String uid, String password) async {
    final response = await http.post(url + "auth/login", headers: {
      'Access-Control-Request-Headers': appControl,
      // 'Authorization': 'Render-App' + token.toString() ?? '-',
    }, body: {
      'email': uid,
      'username': uid,
      'password': password,
    });
    try {
      var res = json.decode(response.body);
      print(res.toString());
      if (response.statusCode == 200) {
        SP.save('token', res['data']['token']);
        SP.save('nama', res['data']['nama']);
        return res['data']['privileges'];
      } else {
        return res['msg'];
      }
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }
}

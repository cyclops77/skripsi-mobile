import 'dart:convert';

import 'package:flutterapp/core/server.dart';
import 'package:flutterapp/model/current-survey-m.dart';
import 'package:flutterapp/model/survey-all-m.dart';
import 'package:flutterapp/viewmodel/spf-vm.dart';
import 'package:http/http.dart' as http;

class SurveyVM {
  static String url = Server.now;
  static String appControl = 'Lumen-App debugging123';
  static Future getSurveyOffline() async {
    List data = [];
    List<String> namaList = await SP.getList('namaList') ?? [];
    List<String> alamatList = await SP.getList('alamatList') ?? [];
    List<String> penghasilanList = await SP.getList('penghasilanList') ?? [];
    List<String> dindingList = await SP.getList('dindingList') ?? [];
    List<String> lantaiList = await SP.getList('lantaiList') ?? [];
    List<String> atapList = await SP.getList('atapList') ?? [];
    List<String> pendidikanAnakList =
        await SP.getList('pendidikanAnakList') ?? [];
    for (var i = 0; i < namaList.length; i++) {
      Map dataMap = new Map();
      dataMap['nama'] = namaList[i];
      dataMap['alamat'] = alamatList[i];
      dataMap['penghasilan'] = penghasilanList[i];
      dataMap['dinding'] = dindingList[i];
      dataMap['lantai'] = lantaiList[i];
      dataMap['atap'] = atapList[i];
      dataMap['pendidikanAnak'] = pendidikanAnakList[i];
      data.add(dataMap);
    }
    return data;
  }

  static Future getSurveyAll() async {
    var token = await SP.getToken();
    final response = await http.get(
      url + "survey",
      headers: {
        'Access-Control-Request-Headers': appControl,
        'Authorization': 'Render-App ' + token.toString() ?? '-',
      },
    );
    try {
      var data = json.decode(response.body);
      final List<SurveyModel> x = surveyModelFromJson(data['data']);
      print(data.toString());
      // x.sort((b, a) => a.createdAt.compareTo(b.updatedAt));
      return x;
    } catch (e) {}
  }

  static Future getSurveyCurrent() async {
    var token = await SP.getToken();
    final response = await http.get(
      url + "survey/current",
      headers: {
        'Access-Control-Request-Headers': appControl,
        'Authorization': 'Render-App ' + token.toString() ?? '-',
      },
    );
    try {
      var data = json.decode(response.body);
      print(data.toString());
      final List<SurveyModel> x = surveyModelFromJson(data['data']);
      x.sort((b, a) => a.createdAt.compareTo(b.updatedAt));
      return x;
    } catch (e) {}
  }

  static Future storeSurvey({userid, nama, alamat, tanggal}) async {
    var token = await SP.getToken();
    final response = await http.post(url + "survey/create", headers: {
      'Access-Control-Request-Headers': appControl,
      'Authorization': 'Render-App ' + token.toString() ?? '-',
    }, body: {
      'user_id': userid,
      'nama': nama,
      'alamat': alamat,
      'tanggal': tanggal,
    });
    try {
      var data = json.decode(response.body);
      return data;
    } catch (e) {}
  }

  static Future updateSurvey(
      {penghasilan,
      kualitasDinding,
      kualitasLantai,
      kualitasAtap,
      pendidikanAnak,
      id}) async {
    var token = await SP.getToken();
    final response = await http.put(url + "survey/update/" + id, headers: {
      'Access-Control-Request-Headers': appControl,
      'Authorization': 'Render-App ' + token.toString() ?? '-',
    }, body: {
      'penghasilan': penghasilan.toString().replaceAll(' ', ''),
      'kualitasDinding': kualitasDinding,
      'kualitasLantai': kualitasLantai,
      'kualitasAtap': kualitasAtap,
      'pendidikanAnak': pendidikanAnak,
    });
    try {
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
    } catch (e) {}
  }
}

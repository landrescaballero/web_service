import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/history.dart';

class HistorySource {
  final String apiKey = 'GTakIp';

  Future<bool> saveSession(History history) async {
    logInfo("Web service, saving history");
    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKey/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(history.toJson()),
    );

    if (response.statusCode == 201) {
      logInfo("Saved");
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<List> getHis(String email) async {
    logInfo("Web service, saving history");
    List<dynamic> data = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data?email=$email");

    var response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);
      logInfo(data);
      return data;
    } else {
      logError("Got error code ${response.statusCode}");
      return data;
    }
  }
}

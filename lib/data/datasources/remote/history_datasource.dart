import 'dart:convert';

import 'package:f_web_authentication/data/datasources/remote/models/local_history.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';

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
  Future<void> addElement(LocalHistorial entry) async {
    logInfo("Web service, saving history");
    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKey/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(entry.toJson()),
    );

    if (response.statusCode == 201) {
      logInfo("Saved");
    } else {
      logError("Got error code ${response.statusCode}");
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
      return data;
    } else {
      logError("Got error code ${response.statusCode}");
      return data;
    }
  }

  Future<bool> verifyhis(int id) async {
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data/$id");

    var response = await http.get(request);
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> deleteHis(int id) async {
    logInfo("Web service, delete history");
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data/$id");

    var response = await http.delete(request);

    if (response.statusCode == 200) {
      logInfo("Deleted");
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<List> getAll() async {
    logInfo("Web service, saving history");
    List<dynamic> data = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data");
    var response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);
      return data;
    } else {
      logError("Got error code ${response.statusCode}");
      return data;
    }
  }
}

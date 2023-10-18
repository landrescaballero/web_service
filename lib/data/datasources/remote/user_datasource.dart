import 'dart:convert';

import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';

import '../../../domain/models/user.dart';

class UserDataSource {
  final String apiKey = 'wiZQez';
  PlayerController playerController = Get.find();

  Future<bool> getUser(String email, String password) async {
    logInfo("Web service, verifying user");
    var request = Uri.parse(
        "https://retoolapi.dev/$apiKey/data?email=$email&password=$password");

    var response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      playerController.setValues(data[0]);
      if (data.length > 0) {
        logInfo("User verified");
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> verifyUser(String email) async {
    logInfo("Web service, verifying user");
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data?email=$email");

    var response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      if (data.length > 0) {
        logInfo("User verified");
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> addUser(User user) async {
    logInfo("Web service, Adding user");

    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKey/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }
  //obtener todos los usuarios de la base de datos

  Future<List> getAll() async {
    logInfo("Web service, getting all users");
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data");

    var response = await http.get(request);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      logInfo("All users retrieved");
      return Future.value(data);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value([]);
    }
  }

  Future<bool> updateUser() async {
    logInfo("Web service, Updating user");
    User user = User(
        firstName: playerController.firstName.value,
        lastName: playerController.lastName.value,
        email: playerController.email.value,
        password: playerController.password.value,
        id: playerController.id.value,
        birthday: playerController.birthday.value,
        course: playerController.course.value,
        difficult: playerController.difficult.value.toString(),
        school: playerController.school.value);
    final response = await http.put(
      Uri.parse("https://retoolapi.dev/$apiKey/data/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    logInfo(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/data/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> simulateProcess(String baseUrl, String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      logInfo('simulateProcess access ok');
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }
}

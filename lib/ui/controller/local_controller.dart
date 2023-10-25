import 'package:connectivity/connectivity.dart';
import 'package:f_web_authentication/domain/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';

import '../../domain/use_case/user_usecase.dart';

// ignore: camel_case_types
class Local_controller extends GetxController {
  final UserUseCase userUseCase = Get.find();
  var local = <Box>[].obs;
  RxBool logged = false.obs;

  Future<void> sync() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    logInfo(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      logInfo("You are OFFLINE, getting from local");
    } else {
      logInfo("You are ONLINE, getting from web");
      List? remoteData = await downloadDataFromServer();
      logInfo("remoteData");
      await updateLocalData(remoteData!);
      logInfo("final");
      var lista = await userUseCase.getAllusersLocal();
      if (lista.isNotEmpty) {
        await uploadLocalDataToServer(lista);
      }
      logInfo("Sincornizacion Completa");
    }
  }

  Future<void> uploadLocalDataToServer(List localData) async {
    for (var localItem in localData) {
      if (kDebugMode) {
        print(localItem.email);
        print(localItem.password);
      }
      final remoteItem =
          await userUseCase.getUser(localItem.email, localItem.password);

      if (remoteItem != false) {
        logInfo("Ya esta ");
        // Si existe un elemento remoto con el mismo ID, actualiza los datos remotos
      } else {
        // Si no existe, inserta los datos locales en el servidor
        await userUseCase.addUser(localItem);
      }
    }
  }

  Future<List?> downloadDataFromServer() async {
    List<dynamic> remoteData = await userUseCase.getAllusers();
    if (remoteData.isNotEmpty) {
      return remoteData;
    } else {
      logError('Error al obtener datos del servidor');
      return null;
    }
  }

  Future<void> updateLocalData(List remoteData) async {
    if (kDebugMode) {
      print(remoteData);
    }
    for (var userData in remoteData) {
      var useru = User(
        id: userData['id'],
        email: userData['email'].toString(),
        course: userData['course'].toString(),
        school: userData['school'].toString(),
        birthday: userData['birthday'].toString(),
        lastName: userData['lastname'].toString(),
        password: userData['password'].toString(),
        firstName: userData['firstname'].toString(),
        difficult: userData['diff'].toString(),
      );
      var localItem =
          await userUseCase.getUserLocal(useru.email, useru.password);

      if (kDebugMode) {
        print(localItem);
        print(useru.id);
      }
      if (localItem != false) {
        // Si existe un elemento local con el mismo ID, actualiza los datos locales
        logInfo("ya esta");
      } else {
        // Si no existe, inserta los datos remotos en la base de datos local
        await userUseCase.addUserLocal(useru);
      }
    }
  }
}

import 'dart:math';

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
    if (connectivityResult == ConnectivityResult.none) {
      logInfo("You are OFFLINE, getting from local");
      local.value = await userUseCase.getAllusersLocal() as List<Box>;
      if (local.isNotEmpty) {
        await uploadLocalDataToServer(local);
      }
    } else {
      logInfo("You are ONLINE, getting from web");
      List? remoteData = await downloadDataFromServer();
      logInfo("remoteData");
      await updateLocalData(remoteData!);
    }
  }

  Future<void> uploadLocalDataToServer(List localData) async {
    for (var localItem in localData) {
      final remoteItem =
          await userUseCase.getUser(localItem.email, localItem.password);

      // Comprueba si el elemento local existe en el servidor remoto
      // ignore: unnecessary_null_comparison
      if (remoteItem != null) {
        // Si existe un elemento remoto con el mismo ID, actualiza los datos remotos
        await userUseCase.updateUser();
      } else {
        // Si no existe, inserta los datos locales en el servidor
        await userUseCase.addUser(localItem);
      }
      logInfo("uploadLocalDataToServer");
    }
  }

  Future<List<User>?> downloadDataFromServer() async {
  List<dynamic> rawData = await userUseCase.getAllusers();
   logInfo("rawData");
   if (kDebugMode) {
     print(rawData);
   }
   
  // Convierte los elementos de dynamic a User
  List<User> remoteData = rawData.map((item) => User.fromJson(item)).toList();
   logInfo("rawData23");

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
    for (var user in remoteData) {
      var localItem = await userUseCase.getUserLocal(user.email, user.password);
      logInfo("localItem");

      if (kDebugMode) {
        print(localItem);
      }
      // ignore: unnecessary_null_comparison
      if (localItem != null) {
        // Si existe un elemento local con el mismo ID, actualiza los datos locales
        await userUseCase.updateUserLocal();
      } else {
        // Si no existe, inserta los datos remotos en la base de datos local
        await userUseCase.addUserLocal(user);
      }
    }
  }
}

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:f_web_authentication/data/datasources/remote/models/local_history.dart';
import 'package:f_web_authentication/domain/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/use_case/user_usecase.dart';

// ignore: camel_case_types
class Local_controller extends GetxController {
  final UserUseCase userUseCase = Get.find();
  RxBool connectivity = true.obs;
  //final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  bool get isConnected => connectivity.value;

  void isOnline() {
    logInfo("Checking internet Connection web...");
    connectivity.value = html.window.navigator.onLine!;
    html.window.onOnline.listen((_) {
      connectivity.value = true;
    });
    html.window.onOffline.listen((_) {
      connectivity.value = false;
    });
  }

  Future<void> sync() async {
    isOnline();
    if (isConnected == false) {
      logInfo("You are OFFLINE, getting from local");
    } else {
      logInfo("You are ONLINE, getting from web");

      List? remoteData = await downloadDataFromServer();
      await updateLocalData(remoteData!);
      var lista = await userUseCase.getAllusersLocal();
      if (lista.isNotEmpty) {
        await uploadLocalDataToServer(lista);
      }

      logInfo("historial sicronizacion");

      List? historyremoteData = await downloadDataFromServerHis();
      logInfo("remoteData");
      await updateLocalDataHis(historyremoteData!);
      var listahis = await userUseCase.getAllLocal();
      if (kDebugMode) {
        print(listahis);
      }
      if (listahis.isNotEmpty) {
        logInfo("final rrrr");
        await uploadLocalDataToServerHis(listahis);
      }
      logInfo("Sincornizacion Completa");
    }
  }

  Future<void> uploadLocalDataToServer(List localData) async {
    for (var localItem in localData) {
      final remoteItem = await userUseCase.verifyUser(localItem.email);
      if (remoteItem != false) {
      } else {
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
      var localItem = await userUseCase.verifyUserLocal(useru.email);
      if (localItem != false) {
      } else {
        await userUseCase.addUserLocal(useru);
      }
    }
  }


  Future<void> uploadLocalDataToServerHis(List localData) async {
    if (kDebugMode) {
      print(localData);
    }
    for (var localItem in localData) {
      final remoteItem = await userUseCase.verifyhis(localItem.id);
      if (remoteItem != false) {
        //logInfo("Ya esta ");
        // Si existe un elemento remoto con el mismo ID, actualiza los datos remotos
      } else {
        // Si no existe, inserta los datos locales en el servidor
        await userUseCase.saveHis(localItem);
      }
    }
  }

  Future<List?> downloadDataFromServerHis() async {
    List<dynamic> remoteData = await userUseCase.getAll();
    logInfo("remoteData");
    if (kDebugMode) {
      print(remoteData.runtimeType);
    }
    if (remoteData.isNotEmpty) {
      return remoteData;
    } else {
      logError('Error al obtener datos del servidor');
      return null;
    }
  }

  Future<void> updateLocalDataHis(List historyremoteData) async {
    //actulizar historial local con los datos del servidor
    for (var history in historyremoteData) {
      var histor = LocalHistorial(
        id: history["id"],
        time: history["time"],
        email: history["email"].toString(),
        question1: history["question1"],
        question2: history["question2"],
        question3: history["question3"],
        question4: history["question4"],
        question5: history["question5"],
        question6: history["question6"],
      );
    
      var localItem = await userUseCase.verifyhisLocal(histor.id);
      print(localItem);
      if (localItem != false) {
        //logInfo("ya esta");
      } else {
        await userUseCase.addelementLocal(histor);
      }
    }
  }
}

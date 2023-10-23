import 'package:connectivity/connectivity.dart';
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
      await updateLocalData(remoteData!);
    }
  }

  Future<void> uploadLocalDataToServer(List localData) async {
  for (var localItem in localData) {
    final remoteItem = await userUseCase.getUser(localItem.email, localItem.password); 

    // Comprueba si el elemento local existe en el servidor remoto
    // ignore: unnecessary_null_comparison
    if (remoteItem != null) {
      // Si existe un elemento remoto con el mismo ID, actualiza los datos remotos
      await userUseCase.updateUser();
    } else {
      // Si no existe, inserta los datos locales en el servidor
      await userUseCase.addUser(localItem);
    }
  }
}

  Future<List?> downloadDataFromServer() async {
    final List remoteData =
        await userUseCase.getAllusers(); // Usa tu función getAll

    if (remoteData.isNotEmpty) {
      return remoteData;
    } else {
      logError('Error al obtener datos del servidor');
      return null;
    }
  }

  Future<void> updateLocalData(List remoteData) async {
    for (var remoteItem in remoteData) {
      final localItem =
          await userUseCase.getUserLocal(remoteItem.email, remoteItem.password);

      // ignore: unnecessary_null_comparison
      if (localItem != null) {
        // Si existe un elemento local con el mismo ID, actualiza los datos locales
        await userUseCase.updateUserLocal();
      } else {
        // Si no existe, inserta los datos remotos en la base de datos local
        await userUseCase.addUserLocal(remoteItem);
      }
    }
  }
}

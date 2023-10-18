import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';

import '../../domain/use_case/user_usecase.dart';

class Local_controller extends GetxController{
  final UserUseCase userUseCase = Get.find();
  var local = <Box>[].obs;


  RxBool logged = false.obs;
  //funcion para sincronizar los datos de la base de datos local con la base de datos remota
  Future<void> sync() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Offline: Retrieve game sessions from local storage
      logInfo("You are OFFLINE, getting from local");
      // logged.value = await userUseCase.getUserLocal(email, password);
      //return logged.value;
    } else {
      List local= await userUseCase.getAllusersLocal();
      // Online: Retrieve game sessions from the web service
      logInfo("You are ONLINE, getting from web");
      
    }
  }

}

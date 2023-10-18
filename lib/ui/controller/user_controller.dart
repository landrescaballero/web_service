import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/user.dart';
import '../../domain/use_case/user_usecase.dart';

class UserController extends GetxController {
  final UserUseCase userUseCase = Get.find();
  RxBool logged = false.obs;

  bool get isLogged => logged.value;
  Future<void> logOut() async {
    logged.value = false;
  }

  Future<bool> getUser(String email, String password) async {
    logInfo("Getting users");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Offline: Retrieve game sessions from local storage
      logInfo("You are OFFLINE, getting from local");
      // logged.value = await userUseCase.getUserLocal(email, password);
      return logged.value;
    } else {
      // Online: Retrieve game sessions from the web service
      logInfo("You are ONLINE, getting from web");
      logged.value = await userUseCase.getUser(email, password);
      return logged.value;
    }
  }

  Future<bool> verifyUser(String email) async {
    logInfo("Getting users");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Offline: Retrieve game sessions from local storage
      logInfo("You are OFFLINE, verify user in local");
      logged.value = await userUseCase.verifyUserLocal(email);
      return logged.value;
    } else {
      // Online: Retrieve game sessions from the web service
      logInfo("You are ONLINE, verify user in web");
      logged.value = await userUseCase.verifyUser(email);
      return logged.value;
    }
  }

  addUser(User user) async {
    logInfo("Add user");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Offline: Retrieve game sessions from local storage
      logInfo("You are OFFLINE, add user in local");
      await userUseCase.addUserLocal(user);
    } else {
      // Online: Retrieve game sessions from the web service
      logInfo("You are ONLINE, add user in web");
      await userUseCase.addUser(user);
    }
  }

  updateUser() async {
    logInfo("Update user");
    await userUseCase.updateUser();
  }

  void deleteUser(int id) async {
    await userUseCase.deleteUser(id);
  }

  void simulateProcess() async {
    await userUseCase.simulateProcess();
  }
}

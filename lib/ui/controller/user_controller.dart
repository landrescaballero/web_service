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
    logged.value = await userUseCase.getUser(email, password);
    return logged.value;
  }

  Future<bool> verifyUser(String email) async {
    logInfo("Getting users");
    logged.value = await userUseCase.verifyUser(email);
    return logged.value;
  }

  addUser(User user) async {
    logInfo("Add user");
    await userUseCase.addUser(user);
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

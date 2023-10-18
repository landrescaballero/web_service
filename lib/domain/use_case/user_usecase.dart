import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/user.dart';
import '../repositories/repository.dart';

class UserUseCase {
  final Repository _repository = Get.find();

  UserUseCase();

  Future<bool> getUser(String email, String password) async {
    logInfo("Getting users  from UseCase");
    return await _repository.getUser(email, password);
  }

  Future<void> addUser(User user) async => await _repository.addUser(user);

  Future<void> updateUser() async => await _repository.updateUser();

  deleteUser(int id) async => await _repository.deleteUser(id);

  simulateProcess() async => await _repository.simulateProcess();
}

import 'package:f_web_authentication/domain/models/history.dart';
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

  Future<bool> verifyUser(String email) async {
    logInfo("Getting users  from UseCase");
    return await _repository.verifyUser(email);
  }

  Future<void> addUser(User user) async => await _repository.addUser(user);

  Future<void> updateUser() async => await _repository.updateUser();

  Future<void> saveHis(History his) async{
  logInfo("Saving in repository");
  await _repository.saveHis(his);}

  Future<List> getHis(String email) async{
  logInfo("Saving in repository");
  return await _repository.getHis(email);}

  deleteUser(int id) async => await _repository.deleteUser(id);
}

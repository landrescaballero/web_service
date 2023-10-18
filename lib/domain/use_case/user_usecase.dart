import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/local_data_source.dart';
import '../models/user.dart';
import '../repositories/repository.dart';

class UserUseCase {
  final Repository _repository = Get.find();
  final LocalDataSource _localDataSource = Get.find();

  UserUseCase();
Future<bool> getUserLocal(String email, String password) async {
    logInfo("Getting users  from UseCase");
    return await _localDataSource.getUser(email, password);
  }
  Future<bool> getUser(String email, String password) async {
    logInfo("Getting users  from UseCase");
    return await _repository.getUser(email, password);
  }

  Future<bool> verifyUser(String email) async {
    logInfo("Getting users  from UseCase");
    return await _repository.verifyUser(email);
  }
  Future<bool> verifyUserLocal(String email) async {
    logInfo("Getting users  from UseCase");
    return await _localDataSource.verifyUser(email);
  }

  Future<void> addUser(User user) async => await _repository.addUser(user);
  Future<void> addUserLocal(User user) async => await _localDataSource.addElement(user);

  Future<void> updateUser() async => await _repository.updateUser();
  Future<void> updateUserLocal( ) async => await _localDataSource.updateEntry();

  Future<List> getAllusers() async => await _repository.getAllusers();
  Future<List> getAllusersLocal() async => await _localDataSource.getAll();

  deleteUser(int id) async => await _repository.deleteUser(id);

  simulateProcess() async => await _repository.simulateProcess();
}

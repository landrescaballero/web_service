import 'package:f_web_authentication/data/datasources/remote/models/local_history.dart';
import 'package:f_web_authentication/data/local_history_source.dart';
import 'package:f_web_authentication/domain/models/history.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/local_data_source.dart';
import '../models/user.dart';
import '../repositories/repository.dart';

class UserUseCase {
  final Repository _repository = Get.find();
  final LocalDataSource _localDataSource = Get.find();
  final Localhistory _localhistory = Get.find();

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
  Future<void> addUserLocal(User user) async =>
      await _localDataSource.addElement(user);

  Future<void> updateUser() async => await _repository.updateUser();
  Future<void> updateUserLocal() async => await _localDataSource.updateEntry();

  Future<List> getAllusers() async => await _repository.getAllusers();
  Future<List> getAllusersLocal() async => await _localDataSource.getAll();

  Future<void> saveHis(History his) async {
    logInfo("Saving in repository");
    await _repository.saveHis(his);
  }

  Future<void> saveHisLocal(History his) async {
    logInfo("Saving in local");
    await _localhistory.saveSession(his);
  }
  Future<void>  addelementLocal(LocalHistorial his) async {
    logInfo("Saving in local");
    await _localhistory.addElement(his);
  }
  Future<List> getHis(String email) async {
    logInfo("Saving in repository");
    return await _repository.getHis(email);
  }
  Future<List> getHisLocal(String email) async {
    logInfo("Saving in local");
    return await _localhistory.getHis(email);
  }
  Future<bool> verifyhis(int id) async => await _repository.verifyhis(id);
  Future<bool> verifyhisLocal(int id) async => await _localhistory.verifyhis(id);
  Future<List> getAll() async => await _repository.getAll();
  Future<List> getAllLocal() async => await _localhistory.getAll();
  deleteUser(int id) async => await _repository.deleteUser(id);
}

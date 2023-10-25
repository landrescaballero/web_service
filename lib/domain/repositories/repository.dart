import 'package:f_web_authentication/data/datasources/remote/authentication_datasource.dart';
import 'package:f_web_authentication/data/datasources/remote/models/local_history.dart';
import 'package:f_web_authentication/domain/models/history.dart';

import '../../data/datasources/remote/history_datasource.dart';
import '../../data/datasources/remote/user_datasource.dart';
import '../models/user.dart';

class Repository {
  late AuthenticationDatatasource _authenticationDataSource;
  late UserDataSource _userDatatasource;
  late HistorySource _historyDatatasource;
  String token = "";

  // the base url of the API should end without the /
  final String _baseUrl =
      "http://ip172-18-0-103-cjvmcv8gftqg00dhebr0-8000.direct.labs.play-with-docker.com";

  Repository() {
    _authenticationDataSource = AuthenticationDatatasource();
    _userDatatasource = UserDataSource();
    _historyDatatasource= HistorySource();
  }

  Future<bool> login(String email, String password) async {
    token = await _authenticationDataSource.login(_baseUrl, email, password);
    return true;
  }

  Future<bool> signUp(String email, String password) async =>
      await _authenticationDataSource.signUp(_baseUrl, email, password);

  Future<bool> logOut() async => await _authenticationDataSource.logOut();

  Future<bool> getUser(String email, String password) async =>
      await _userDatatasource.getUser(email, password);

  Future<bool> verifyUser(String email) async =>
      await _userDatatasource.verifyUser(email);

  Future<bool> addUser(User user) async =>
      await _userDatatasource.addUser(user);

  Future<List> getAllusers()async  =>
      await _userDatatasource.getAll();

  Future<bool> updateUser() async => await _userDatatasource.updateUser();

  Future<bool> deleteUser(int id) async =>
      await _userDatatasource.deleteUser(id);

  Future<bool> saveHis(History his) async =>await _historyDatatasource.saveSession(his);
  Future<List> getHis(String email) async =>await _historyDatatasource.getHis(email);
  Future<bool> verifyhis(int id) async =>await _historyDatatasource.verifyhis(id);
  Future<List> getAll() async =>await _historyDatatasource.getAll();
  Future<void>  addelementLocal(LocalHistorial his) async =>await _historyDatatasource.addElement(his);
}

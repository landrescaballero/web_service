import 'package:f_web_authentication/data/datasources/remote/models/some_data_db.dart';
import 'package:f_web_authentication/domain/models/user.dart';
import 'package:hive/hive.dart';

class LocalDataSource {
  Future<void> addElement(User entry) async {
    Hive.box('user').add(SomeData(
        correo: entry.email,
        firstName: entry.firstName,
        lastName: entry.lastName,
        birthday: entry.birthday,
        course: entry.course,
        password: entry.password,
        difficult: entry.difficult,
        school: entry.school));
  }
  Future<bool> getUser(String email, String password) async {
    List<User> usuarios = await getAll();
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email && usuarios[i].password == password) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
  //verificar que el correo no este registrado
  Future<bool> verifyUser(String email) async {
    List<User> usuarios = await getAll();
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
  Future<List<User>> getAll() async {
    return Hive.box('user').values.map((e) => User(
      id: e.key as int,
      email: e.correo,
      firstName: e.firstName,
      lastName: e.lastName,
      birthday: e.birthday,
      course: e.course,
      password: e.password,
      difficult: e.difficult,
      school: e.school,
    )).toList();
  }
  Future<void> deleteAll() async {
    Hive.box('user').clear();
  }
  Future<void> deleteEntry(User entry) async {
    Hive.box('user').deleteAt(entry.id!);
  }
  Future<void> updateEntry(User entry) async {
    Hive.box('user').put(entry.id!, User(
        email: entry.email,
        firstName: entry.firstName,
        lastName: entry.lastName,
        birthday: entry.birthday,
        course: entry.course,
        password: entry.password,
        difficult: entry.difficult,
        school: entry.school));
  }
}

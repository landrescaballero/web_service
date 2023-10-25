
import 'package:f_web_authentication/data/datasources/remote/models/local_history.dart';
import 'package:f_web_authentication/domain/models/history.dart';
import 'package:hive/hive.dart';

//local history
class Localhistory {
  Future<bool> saveSession(History history) async {
    final box = await Hive.openBox('history');
    await box.add(history);
    return Future.value(true);
  }

  Future<void> addElement(LocalHistorial entry) async {
    Hive.box('history').add(LocalHistorial(
        id: entry.id,
        time: entry.time,
        email: entry.email,
        question1: entry.question1,
        question2: entry.question2,
        question3: entry.question3,
        question4: entry.question4,
        question5: entry.question5,
        question6: entry.question6));
  }

  Future<List> getHis(String email) async {
    final box = await Hive.openBox('history');
    List<dynamic> data = [];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i);
      if (item.email == email) {
        data.add(item);
      }
    }
    return data;
  }
  Future<List> getAll() async {
    final box = await Hive.openBox('history');
    List<dynamic> data = [];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i);
      data.add(item);
    }
    return data;
  }
  Future<bool> verifyhis(int id) async {
    final box = await Hive.openBox('history');
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i);
      if (item.id == id) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
}


import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/history.dart';
import '../../domain/use_case/user_usecase.dart';

class HistoryController extends GetxController {
  final UserUseCase userUseCase = Get.find();
  
  saveHis(History his) async {
    logInfo("Saving his");
    await userUseCase.saveHis(his);
  }
  Future<List> getHis(String email){
    return userUseCase.getHis(email);
  }
}

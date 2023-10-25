import 'package:f_web_authentication/ui/controller/local_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/history.dart';
import '../../domain/use_case/user_usecase.dart';

class HistoryController extends GetxController {
  final Local_controller connectionController = Get.find();

  final UserUseCase userUseCase = Get.find();
  List<dynamic> hist = [].obs;

  saveHis(History his) async {
    connectionController.isOnline();
    if (connectionController.isConnected == false) {
      logInfo("You are OFFLINE, Saving his from local");
      await userUseCase.saveHisLocal(his);
    } else {
      logInfo("You are ONLINE, Saving his from web");
      await userUseCase.saveHis(his);
    }
  }

  Future<List> getHis(String email) async {
    connectionController.isOnline();
    if (connectionController.isConnected == false) {
      logInfo("You are OFFLINE, get his from local");
      List<dynamic> listHist = await userUseCase.getHisLocal(email);
      hist.clear();
      for (var element in listHist) {
        hist.add(element);
      }
      return hist;
    } else {
      logInfo("You are ONLINE, get his from web");
      List<dynamic> listHist = await userUseCase.getHis(email);
      hist.clear();
      for (var element in listHist) {
        hist.add(element);
      }
      return hist;
    }
  }
}

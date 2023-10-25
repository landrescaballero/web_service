import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/history.dart';
import '../../domain/use_case/user_usecase.dart';

class HistoryController extends GetxController {
  final UserUseCase userUseCase = Get.find();
  List<dynamic> hist = [].obs;

  saveHis(History his) async {
    logInfo("Saving his");
    await userUseCase.saveHis(his);
  }

  List getHis(String email) {
    List<dynamic> listHist = userUseCase.getHis(email) as List<dynamic>;
    for (var element in listHist) {
      hist.add(element);
    }
    return hist;
  }
}

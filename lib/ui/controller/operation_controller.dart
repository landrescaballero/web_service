import 'package:get/get.dart';


class OperationController extends GetxController {
  //DifficultyController difficultyController = Get.find();
  RxString value = "0".obs;
  RxString op1 = "1".obs;
  RxString op2 = "+".obs;
  RxString op3 = "1".obs;
  RxString answer = "2".obs;

  void increment(String str) {
    if (value == "0".obs) {
      value.value = str;
    } else {
      value.value = value.value + str;
    }
  }

  void reset() {
    value.value = "0";
  }

  void setOp1(String str) {
    op1.value = str;
  }

  void setOp2(String str) {
    op2.value = str;
  }

  void setOp3(String str) {
    op3.value = str;
  }

  void sendanswer() {
    if(value.value==answer.value){
      //respuesta correcta
    }else{
      //respuesta incorrecta
    }
  }
}

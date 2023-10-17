import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperationController extends GetxController {
  DifficultyController difController = Get.find();
  RxString value = "0".obs;
  RxInt n = 0.obs;
  List<RxString> op1 = ["0".obs, "0".obs, "0".obs, "0".obs, "0".obs, "0".obs];
  List<RxString> op2 = ["".obs, "".obs, "".obs, "".obs, "".obs, "".obs];
  List<RxString> op3 = ["0".obs, "0".obs, "0".obs, "0".obs, "0".obs, "0".obs];
  List<RxString> answer = [
    "0".obs,
    "0".obs,
    "0".obs,
    "0".obs,
    "0".obs,
    "0".obs
  ];
  List<RxBool> correct = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ];

  String getOP(int n) {
    if (n < 6) {
      return op1[n].value + op2[n].value + op3[n].value;
    } else {
      return op1[5].value + op2[5].value + op3[5].value;
    }
  }

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

  void setOp1(String str, int i) {
    op1[i].value = str;
  }

  void setOp2(String str, int i) {
    op2[i].value = str;
  }

  void setOp3(String str, int i) {
    op3[i].value = str;
  }

  void setAnswer(String str, int i) {
    answer[i].value = str;
  }

  void sendanswer() {
    if (n.value <= 5) {
      if (value.value == answer[n.value].value) {
        Get.snackbar("Enhorabuena!!", "Respuesta correcta",
            backgroundColor: const Color.fromARGB(255, 95, 245, 68),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(milliseconds: 850));
        reset();
        correct[n.value].value = true;
        incrementN();
      } else {
        Get.snackbar("Sigue intentando", "Respuesta incorrecta",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(milliseconds: 850));
        reset();
        correct[n.value].value = false;
        incrementN();
      }
    }
  }

  void incrementN() {
    n++;
  }

  void begin() {
    n.value = 0;
  }

  bool getAnswer(int i) {
    return correct[i].value;
  }
}

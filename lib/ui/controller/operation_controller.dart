import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperationController extends GetxController {
  DifficultyController difController = Get.find();
  RxString value = "0".obs;
  RxString op1 = "1".obs;
  RxString op2 = "+".obs;
  RxString op3 = "1".obs;
  RxString answer = "2".obs;

  String getOP() {
    return op1.value + op2.value + op3.value;
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

  void setOp1(String str) {
    op1.value = str;
  }

  void setOp2(String str) {
    op2.value = str;
  }

  void setOp3(String str) {
    op3.value = str;
  }

  void setAnswer(String str) {
    answer.value = str;
  }

  void sendanswer() {
    if (value.value == answer.value) {
      Get.snackbar("Enhorabuena!!", "Respuesta correcta",
          backgroundColor: const Color.fromARGB(255, 95, 245, 68),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 850));
      difController.incrementCorrectAnswers();
    } else {
      Get.snackbar("Sigue intentando", "Respuesta incorrecta",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 850));
    }
    value.value = "0";
  }
}

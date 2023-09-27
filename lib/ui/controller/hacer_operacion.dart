import 'dart:math';

import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:f_web_authentication/ui/controller/verificar.dart';
import 'package:get/get.dart';

class OperationGeneratorController extends GetxController {
  DifficultyController difficultyController = Get.put(DifficultyController());
  OperationController operationController = Get.find();
  ResultVerificationController resultVerificationController =
      Get.put(ResultVerificationController());
  RxInt num1 = 0.obs;
  RxInt num2 = 0.obs;
  RxString operator = "".obs;
  RxInt res = 0.obs;

  void generateRandomOperation() {
    difficultyController.calculateDifficulty();
    int difficulty=difficultyController.difficulty.value;
    num1.value = generateNumber(difficulty);
    num2.value = generateNumber(difficulty);
    operator.value = generateOperation();

    res.value = resultVerificationController.verifyResult();

    operationController.setOp1(num1.value.toString());
    operationController.setOp2(operator.value);
    operationController.setOp3(num2.value.toString());
   // operationController.setAnswer(res.value.toString());
  }

  int generateNumber(int difficulty) {
    final random = Random();
    return random.nextInt(difficulty * 10) + 1;
  }

  String generateOperation() {
    int difficulty=difficultyController.difficulty.value;

    final operators = ['+', '-', '*','/'];
    var operator="";
    if (difficulty <= 5) {
      operator= operators[0];
    }
    if (difficulty < 10 && difficulty>5) {
      operator= operators[1];
    }
    if (difficulty < 15 && difficulty>10) {
      operator= operators[2];
    }
    if (difficulty < 20 && difficulty>15) {
      operator= operators[3];
    }
    return operator;
  }
}

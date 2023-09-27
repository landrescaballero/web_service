import 'dart:math';

import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:get/get.dart';

class OperationGeneratorController extends GetxController {
  final DifficultyController difficultyController = Get.find();
  final OperationController operationController = Get.find();
  final num1 = 0.obs;
  final num2 = 0.obs;
  final operator = "".obs;
  

  void generateRandomOperation() {
    difficultyController.calculateDifficulty();
    int difficulty=difficultyController.difficulty.value;
    num1.value = generateNumber(difficulty);
    num2.value = generateNumber(difficulty);
    operator.value = generateOperation();
    
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

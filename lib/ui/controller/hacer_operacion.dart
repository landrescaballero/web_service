import 'dart:math';

import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:get/get.dart';

class OperationGeneratorController extends GetxController {
  final DifficultyController difficultyController = Get.find();

  String generateRandomOperation() {
    final int difficulty = difficultyController.calculateDifficulty();
    final num1 = generateNumber(difficulty);
    final num2 = generateNumber(difficulty);
    final operator = generateOperation();

    final operation = '$num1 $operator $num2';

    return operation;
  }

  int generateNumber(int difficulty) {
    final random = Random();
    return random.nextInt(difficulty * 10) + 1;
  }

  String generateOperation() {
    final operators = ['+', '-', '*','/'];
    var operator="";
    if (difficultyController.calculateDifficulty() <= 5) {
      operator= operators[0];
    }
    if (difficultyController.calculateDifficulty() < 10 && difficultyController.calculateDifficulty()>5) {
      operator= operators[1];
    }
    if (difficultyController.calculateDifficulty() < 15 && difficultyController.calculateDifficulty()>10) {
      operator= operators[2];
    }
    if (difficultyController.calculateDifficulty() < 20 && difficultyController.calculateDifficulty()>15) {
      operator= operators[3];
    }
    return operator;
  }
}

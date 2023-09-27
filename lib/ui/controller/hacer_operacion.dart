import 'dart:math';

import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
    final operators = ['+', '-', '*'];
    final random = Random();
    return operators[random.nextInt(operators.length)];
  }
}

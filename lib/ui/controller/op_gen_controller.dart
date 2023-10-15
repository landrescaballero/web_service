import 'dart:math';

import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:get/get.dart';

class OperationGeneratorController extends GetxController {
  OperationController operationController = Get.find();
  DifficultyController difficultyController = Get.find();

  List<int> num1 = List<int>.filled(5, 0);
  List<int> num2 = List<int>.filled(5, 0);
  List<String> operator = ["", "", "", "", "", ""];

  void generateRandomOperation() {
    difficultyController.calculateDifficulty();
    for (var i = 0; i < 5; i++) {
      operator[i] = generateOperation();
      num1[i] = generateNumber1(i);
      num2[i] = generateNumber2(i);
      int res = verifyResult(i);

      operationController.setOp1(num1[i].toString(), i);
      operationController.setOp2(operator[i], i);
      operationController.setOp3(num2[i].toString(), i);
      operationController.setAnswer(res.toString(), i);
    }
  }

  int generateNumber1(int i) {
    int difficulty = difficultyController.difficulty.value;
    final random = Random();
    if (operator[i] != '*') {
      if (difficulty % 2 == 0) {
        return random.nextInt(100) + 1;
      } else {
        return random.nextInt(10) + 1;
      }
    } else {
      return random.nextInt(10) + 1;
    }
  }

  int generateNumber2(int i) {
    int difficulty = difficultyController.difficulty.value;
    final random = Random();
    if (operator[i] != '*') {
      if (difficulty % 2 == 0) {
        if (operator[i] == '-') {
          int n = 1000;
          while (n > num1[i]) {
            n = random.nextInt(100) + 1;
          }
          return n;
        }
        return random.nextInt(100) + 1;
      } else {
        if (operator[i] == '-') {
          int n = 1000;
          while (n > num1[i]) {
            n = random.nextInt(10) + 1;
          }
          return n;
        }
        return random.nextInt(10) + 1;
      }
    } else {
      return random.nextInt(10) + 1;
    }
  }

  String generateOperation() {
    int difficulty = difficultyController.difficulty.value;

    List<String> operators = [];
    switch (difficulty) {
      case 1:
        operators = ['+'];
        break;
      case 2:
        operators = ['+'];
        break;
      case 3:
        operators = ['+', '-'];
        break;
      case 4:
        operators = ['+', '-'];
        break;
      case 5:
        operators = ['+', '-', '*'];
        break;
      case 6:
        operators = ['+', '-', '*'];
        break;
      case 7:
        operators = ['+', '-', '*', '/'];
        break;
      case 8:
        operators = ['+', '-', '*', '/'];
        break;
    }

    final random = Random();
    return operators[random.nextInt(operators.length)];
  }

  int verifyResult(int i) {
    // Generar una nueva operación utilizando OperationGeneratorController
    int correctAnswer = 0;

    // Realizar la operación matemática y calcular la respuesta correcta
    switch (operator[i]) {
      case '+':
        correctAnswer = num1[i] + num2[i];
        break;
      case '-':
        correctAnswer = (num1[i] - num2[i]);
        break;
      case '*':
        correctAnswer = (num1[i] * num2[i]);
        break;
      case '/':
        correctAnswer = (num1[i] ~/ num2[i]);
        break;
    }

    return correctAnswer;
  }
}

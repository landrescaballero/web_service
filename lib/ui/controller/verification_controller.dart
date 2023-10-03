import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:get/get.dart';

class ResultVerificationController extends GetxController {
  DifficultyController difficultyController = Get.find();
  OperationController operationController = Get.find();

  int verifyResult() {
    // Generar una nueva operación utilizando OperationGeneratorController
    final num1 = int.parse(operationController.op1.value);
    final num2 = int.parse(operationController.op3.value);
    final operator = operationController.op2.value;

    int correctAnswer = 0;

    // Realizar la operación matemática y calcular la respuesta correcta
    switch (operator) {
      case '+':
        correctAnswer = num1 + num2;
        break;
      case '-':
        correctAnswer = num1 - num2;
        break;
      case '*':
        correctAnswer = num1 * num2;
        break;
      case '/':
        correctAnswer = num1 ~/ num2;
        break;
      default:
        // Si el operador no es válido, considerar la operación incorrecta.
        difficultyController.incrementIncorrectAnswers();
    }
    return correctAnswer;
  }
}

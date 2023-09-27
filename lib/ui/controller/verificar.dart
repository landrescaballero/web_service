import 'package:get/get.dart';
import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:f_web_authentication/ui/controller/hacer_operacion.dart';

class ResultVerificationController extends GetxController {
  final DifficultyController difficultyController = Get.find();
  final OperationGeneratorController operationGeneratorController =
      Get.put(OperationGeneratorController());

  bool verifyResult(int userAnswer) {
    // Generar una nueva operación utilizando OperationGeneratorController
    final operation = operationGeneratorController.generateRandomOperation();

    // Dividir la operación en sus componentes (números y operador)
    final parts = operation.split(' ');

    if (parts.length != 3) {
      // Si la operación no tiene el formato correcto (por ejemplo, "5 + 3"), se considera incorrecta.
      difficultyController.incrementIncorrectAnswers();
      return false;
    }

    final num1 = int.tryParse(parts[0]);
    final operator = parts[1];
    final num2 = int.tryParse(parts[2]);

    if (num1 == null || num2 == null) {
      return false;
    }

    int correctAnswer;

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
      default:
        // Si el operador no es válido, considerar la operación incorrecta.
        difficultyController.incrementIncorrectAnswers();
        return false;
    }

    // Comparar la respuesta del usuario con la respuesta correcta
    if (userAnswer == correctAnswer) {
      difficultyController.incrementCorrectAnswers();
      return true;
    } else {
      difficultyController.incrementIncorrectAnswers();
      return false;
    }
  }
}

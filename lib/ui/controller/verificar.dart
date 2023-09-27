import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:f_web_authentication/ui/controller/hacer_operacion.dart';
import 'package:get/get.dart';

class ResultVerificationController extends GetxController {
  final DifficultyController difficultyController = Get.find();
  final OperationGeneratorController operationGeneratorController =
      Get.put(OperationGeneratorController());

  bool verifyResult(int userAnswer) {
    // Generar una nueva operación utilizando OperationGeneratorController
    final num1=operationGeneratorController.num1.value;
    final num2=operationGeneratorController.num2.value;
    final operator=operationGeneratorController.operator.value;

    // ignore: unnecessary_null_comparison
    if (num1 == null || num2 == null || operator == null) {
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

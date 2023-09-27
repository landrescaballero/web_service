import 'package:f_web_authentication/ui/controller/dificultad.dart';
import 'package:f_web_authentication/ui/controller/hacer_operacion.dart';
import 'package:get/get.dart';

class ResultVerificationController extends GetxController {
  DifficultyController difficultyController = Get.find();
  OperationGeneratorController operationGeneratorController =
  Get.put(OperationGeneratorController());

  int verifyResult() {
    // Generar una nueva operación utilizando OperationGeneratorController
    final num1=operationGeneratorController.num1.value;
    final num2=operationGeneratorController.num2.value;
    final operator=operationGeneratorController.operator.value;

    int correctAnswer=0;

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

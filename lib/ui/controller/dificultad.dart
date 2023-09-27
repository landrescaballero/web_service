import 'package:get/get.dart';

class DifficultyController extends GetxController {
  RxInt correctAnswers = 0.obs;
  RxInt incorrectAnswers = 0.obs;
  RxInt difficulty = 1.obs;

  void incrementCorrectAnswers() {
    correctAnswers++;
  }

  void incrementIncorrectAnswers() {
    incorrectAnswers++;
  }

  void calculateDifficulty() {
    difficulty.value = (correctAnswers ~/ 5) + 1;
  }
}

import 'package:get/get.dart';

class DifficultyController extends GetxController {
  RxInt correctAnswers = 0.obs;
  RxInt incorrectAnswers = 0.obs;

  void incrementCorrectAnswers() {
    correctAnswers++;
  }

  void incrementIncorrectAnswers() {
    incorrectAnswers++;
  }

  int calculateDifficulty() {
    int difficulty = (correctAnswers ~/ 5) + 1;
    return difficulty;
  }
}

import 'package:get/get.dart';

class DifficultyController extends GetxController {
  RxInt correctAnswers = 0.obs;
  RxInt incorrectAnswers = 0.obs;
  RxInt difficulty = 1.obs;

  void incrementCorrectAnswers(int num) {
    correctAnswers.value += num;
  }

  void incrementIncorrectAnswers(int num) {
    incorrectAnswers.value += num;
  }

  void calculateDifficulty() {
    if (correctAnswers.value >= incorrectAnswers.value + 6 &&
        correctAnswers.value >= 6) {
      difficulty++;
      correctAnswers.value = 0;
      incorrectAnswers.value = 0;
    }
  }

  bool nivelUp() {
    if (correctAnswers.value >= incorrectAnswers.value + 6 &&
        correctAnswers.value >= 6) {
      calculateDifficulty();
      return true;
    } else {
      calculateDifficulty();
      return false;
    }
  }
}

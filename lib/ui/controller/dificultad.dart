import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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

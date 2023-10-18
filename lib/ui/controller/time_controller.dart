import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  Rx<Duration> elapsedTime = Duration.zero.obs;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value = Duration(seconds: timer.tick);
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  int getTime() {
    return elapsedTime.value.inSeconds;
  }

  void resetTimer() {
    elapsedTime.value = Duration.zero;
  }
}

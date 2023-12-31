import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/history_controller.dart';
import 'package:f_web_authentication/ui/controller/op_gen_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/time_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/pages/content/history_page.dart';
import 'package:f_web_authentication/ui/pages/content/operations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  UserController userController = Get.find();
  DifficultyController diffController = Get.find();
  OperationController operationController = Get.find();
  OperationGeneratorController opGenController = Get.find();
  TimerController timerController = Get.find();
  PlayerController playerController = Get.find();
  HistoryController historyController = Get.find();

  _logout() async {
    try {
      await userController.logOut();
      Get.to(const Central());
    } catch (e) {
      logInfo(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome"), actions: [
        IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              historyController.getHis(playerController.email.value);
              Get.to(const HistoryPage());
            }),
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Obx(() => Text("Bienvenido, ${playerController.firstName.value}.",
            style: const TextStyle(fontSize: 40))),
        const SizedBox(height: 40),
        Text("Nivel Actual: ${diffController.difficulty.value}",
            style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text("Respuestas correctas: ${diffController.correctAnswers.value}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.green,
            )),
        const SizedBox(height: 20),
        Text("Respuestas incorrectas: ${diffController.incorrectAnswers.value}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            )),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("begin operations");
          operationController.reset();
          operationController.begin();
          opGenController.generateRandomOperation();
          timerController.resetTimer();
          timerController.startTimer();
          Get.to(() => const Operations());
        },
        child: const Text("Iniciar"),
      ),
    );
  }
}

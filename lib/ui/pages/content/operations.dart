import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:f_web_authentication/ui/controller/time_controller.dart';
import 'package:f_web_authentication/ui/pages/content/results_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../utils.dart';
import '../../controller/authentication_controller.dart';
import '../../controller/user_controller.dart';

class Operations extends StatefulWidget {
  const Operations({super.key});

  @override
  State<Operations> createState() => _Operations();
}

class _Operations extends State<Operations> {
  UserController userController = Get.find();
  AuthenticationController authenticationController = Get.find();
  OperationController operationController = Get.find();
  DifficultyController difController = Get.find();
  TimerController timerController = Get.find();

  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      logInfo(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vamos tu puedes!!"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() => Text(
                  minutero(timerController.elapsedTime.value.inSeconds),
                  style: const TextStyle(fontSize: 24),
                )),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 20),
        Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 54, 44, 43),
                width: 2,
              ),
              color: const Color.fromARGB(255, 73, 109, 67),
            ),
            child: Column(children: [
              operators(),
              const SizedBox(
                height: 20,
              ),
              answer(),
            ])),
        const SizedBox(height: 20),
        buttons(),
        const SizedBox(height: 20),
        Obx(
          () => Text("Dificultad: ${difController.difficulty.value}",
              style: const TextStyle(fontSize: 30)),
        ),
      ])),
    );
  }

  Widget answer() {
    return Obx(() => Text(operationController.value.value.toString(),
        style: const TextStyle(fontSize: 30)));
  }

  Widget operators() {
    return Obx(() => Text(
        operationController.getOP(operationController.n.value),
        style: const TextStyle(fontSize: 30)));
  }

  Widget buttons() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
            onPressed: () {
              operationController.increment("1");
            },
            child: const Text("1")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("2");
            },
            child: const Text("2")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("3");
            },
            child: const Text("3")),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
            onPressed: () {
              operationController.increment("4");
            },
            child: const Text("4")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("5");
            },
            child: const Text("5")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("6");
            },
            child: const Text("6")),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
            onPressed: () {
              operationController.increment("7");
            },
            child: const Text("7")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("8");
            },
            child: const Text("8")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("9");
            },
            child: const Text("9")),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              operationController.reset();
            },
            child: const Text("C")),
        FloatingActionButton(
            onPressed: () {
              operationController.increment("0");
            },
            child: const Text("0")),
        FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 95, 245, 68),
            onPressed: () {
              operationController.sendanswer();
              if (operationController.n.value == 6) {
                int numC = 0;
                for (var j = 0; j < 6; j++) {
                  if (operationController.getAnswer(j)) {
                    numC++;
                  }
                }
                difController.incrementCorrectAnswers(numC);
                difController.incrementIncorrectAnswers(6 - numC);
                timerController.stopTimer();
                Get.to(const ResultPage());
                _logout();
              }
            },
            child: const Text("OK")),
      ])
    ]);
  }
}

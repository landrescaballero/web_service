import 'package:f_web_authentication/domain/models/history.dart';
import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/history_controller.dart';
import 'package:f_web_authentication/ui/controller/op_gen_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/time_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/pages/content/congrats.dart';
import 'package:f_web_authentication/ui/pages/content/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../utils.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {
  UserController userController = Get.find();
  OperationController operationController = Get.find();
  OperationGeneratorController opGenController = Get.find();
  DifficultyController diffController = Get.find();
  TimerController timerController = Get.find();
  HistoryController historyController = Get.find();
  PlayerController playerController = Get.find();

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
      appBar: AppBar(title: const Text("Resultados"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Sus resultados fueron: ", style: TextStyle(fontSize: 40)),
        const SizedBox(height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Operacion 1: ",
            style: TextStyle(fontSize: 20),
          ),
          respuesta(operationController.getAnswer(0))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Operacion 2: ",
            style: TextStyle(fontSize: 20),
          ),
          respuesta(operationController.getAnswer(1))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Operacion 3: ",
            style: TextStyle(fontSize: 20),
          ),
          respuesta(operationController.getAnswer(2))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Operacion 4: ",
            style: TextStyle(fontSize: 20),
          ),
          respuesta(operationController.getAnswer(3))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Operacion 5: ",
            style: TextStyle(fontSize: 20),
          ),
          respuesta(operationController.getAnswer(4))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Operacion 6: ",
            style: TextStyle(fontSize: 20),
          ),
          respuesta(operationController.getAnswer(5))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Tiempo Transcurrido: ${minutero(timerController.getTime())} ",
            style: const TextStyle(fontSize: 20),
          ),
          respuestamin(timerController.getTime())
        ]),
      ])),
      floatingActionButton: FilledButton(
        onPressed: () async {
          logInfo("new operations");
          await historyController.saveHis(History(
            time: timerController.getTime(),
            email: playerController.email.value,
            question1: operationController.getAnswer(0),
            question2: operationController.getAnswer(1),
            question3: operationController.getAnswer(2),
            question4: operationController.getAnswer(3),
            question5: operationController.getAnswer(4),
            question6: operationController.getAnswer(5),
          ));
          historyController.getHis(playerController.email.value);
          if (diffController.nivelUp()) {
            Get.to(() => const CongratulationPage());
          } else {
            Get.to(() => const WelcomePage());
          }
        },
        child: const Text("Empezar de nuevo"),
      ),
    );
  }
}

Widget respuesta(bool a) {
  //si a es true devolver un unico de check verde y si a es false devolver un icono de error rojo
  if (a == true) {
    return const Icon(Icons.check_box, color: Colors.green);
  } else {
    return const Icon(Icons.indeterminate_check_box, color: Colors.red);
  }
}

Widget respuestamin(int a) {
  //si a es true devolver un unico de check verde y si a es false devolver un icono de error rojo
  if (a < 120) {
    return const Icon(Icons.check_box, color: Colors.green);
  } else {
    return const Icon(Icons.indeterminate_check_box, color: Colors.red);
  }
}

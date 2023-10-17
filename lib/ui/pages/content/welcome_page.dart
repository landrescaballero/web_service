import 'package:f_web_authentication/ui/controller/authentication_controller.dart';
import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/op_gen_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
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
  AuthenticationController authenticationController = Get.find();
  DifficultyController diffController = Get.find();
  OperationController operationController = Get.find();
  OperationGeneratorController opGenController = Get.find();

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
      appBar: AppBar(title: const Text("Welcome"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Bienvenido", style: TextStyle(fontSize: 40)),
        const SizedBox(height: 40),
        Text("Nivel Actual: ${diffController.difficulty.value}",
            style: const TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        Text("Respuestas correctas: ${diffController.correctAnswers.value}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.green,
            )),
        SizedBox(height: 20),
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
          Get.to(() => Operations());
        },
        child: const Text("Iniciar"),
        
      ),
    );
  }
}

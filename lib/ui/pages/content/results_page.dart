import 'package:f_web_authentication/ui/controller/authentication_controller.dart';
import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/op_gen_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:f_web_authentication/ui/pages/content/congrats.dart';
import 'package:f_web_authentication/ui/pages/content/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultState();
}

class _ResultState extends State<ResultPage> {
  AuthenticationController authenticationController = Get.find();
  OperationController operationController = Get.find();
  OperationGeneratorController opGenController = Get.find();
  DifficultyController diffController = Get.find();

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
      ])),
      floatingActionButton: FilledButton(
        onPressed: () async {
          logInfo("new operations");
          if (diffController.nivelUp()) {
            Get.to(() => CongratulationPage());
          } else {
            Get.to(() => WelcomePage());
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

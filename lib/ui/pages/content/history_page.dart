import 'package:f_web_authentication/ui/controller/history_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/pages/content/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  UserController userController = Get.find();
  HistoryController historyController = Get.find();
  PlayerController playerController = Get.find();
  _logout() async {
    try {
      await userController.logOut();
    } catch (e) {
      logInfo(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preguntas(),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const WelcomePage());
        },
        child: const Text("Volver"),
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

Widget preguntas() {
  return const Text("Preguntas: ", style: TextStyle(fontSize: 40));
}

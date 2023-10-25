import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/history_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/pages/content/welcome_page.dart';
import 'package:f_web_authentication/utils.dart';
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
      Get.to(const Central());
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
          const Text("Historial de sesiones:", style: TextStyle(fontSize: 30)),
          const SizedBox(height: 40),
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
  HistoryController historyController = Get.find();
  PlayerController playerController = Get.find();
  logInfo(
      "sesiones: ${historyController.hist.length} ${playerController.email.value}}");
  List<Widget> widgets = [];
  List<dynamic> listHist = historyController.hist;
  logInfo('Lista obtenida');
  for (var element in listHist) {
    widgets.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Sesion: ${element['id']} "),
      respuesta(element['question1']),
      respuesta(element['question2']),
      respuesta(element['question3']),
      respuesta(element['question4']),
      respuesta(element['question5']),
      respuesta(element['question6']),
      Text(" Time: ${minutero(element['time'] ?? 1)}")
    ]));
  }
  return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: widgets));
}

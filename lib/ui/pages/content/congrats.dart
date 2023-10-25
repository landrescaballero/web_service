import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/difficulty_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/pages/content/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class CongratulationPage extends StatefulWidget {
  const CongratulationPage({super.key});

  @override
  State<CongratulationPage> createState() => _CongratulationState();
}

class _CongratulationState extends State<CongratulationPage> {
  UserController userController = Get.find();
  DifficultyController diffController = Get.find();
  PlayerController playerController = Get.find();

  //ir a la pagina de central
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
      appBar: AppBar(title: const Text("Congratulation"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Felicidades", style: TextStyle(fontSize: 45)),
          SizedBox(height: 40),
          Text("Subiste de nivel", style: TextStyle(fontSize: 30)),
          SizedBox(height: 10),
          Text("You are the best!", style: TextStyle(fontSize: 15))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("new operations");

          logInfo("${diffController.difficulty.value}");
          playerController.updateDifficult(diffController.difficulty.value);
          userController.updateUser();
          Get.to(() => const WelcomePage());
        },
        child: const Text("OK"),
      ),
    );
  }
}

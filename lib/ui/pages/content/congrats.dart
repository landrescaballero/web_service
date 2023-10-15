import 'package:f_web_authentication/ui/controller/authentication_controller.dart';
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
  AuthenticationController authenticationController = Get.find();

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
          Get.to(() => WelcomePage());
        },
        child: const Text("OK"),
      ),
    );
  }
}

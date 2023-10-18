import 'package:f_web_authentication/ui/controller/history_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
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
  HistoryController historyController=Get.find();
  PlayerController playerController= Get.find();
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
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        Text(historyController.getHis(playerController.email.value).toString())
      ],)),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Get.to( const HistoryPage());
          },
        child: const Text("Volver"),
      ),
    );
  }
}

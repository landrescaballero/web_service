import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _State();
}

class _State extends State<Page> {
  UserController userController = Get.find();

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
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            }),
      ]),
      body: const Center(child: Text("")),
      floatingActionButton: const FloatingActionButton(
        onPressed: (null),
        child: Text("."),
      ),
    );
  }
}

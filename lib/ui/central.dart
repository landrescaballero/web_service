import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:f_web_authentication/ui/pages/content/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/authentication/login_page.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Obx(() =>
        userController.isLogged ? const WelcomePage() : const LoginPage());
  }
}

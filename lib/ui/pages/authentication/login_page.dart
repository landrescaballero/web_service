import 'package:f_web_authentication/ui/controller/op_gen_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: 'a@a.com');
  final controllerPassword = TextEditingController(text: '123456');
  OperationGeneratorController opGenController = Get.find();
  UserController userController = Get.find();

  _login(theEmail, thePassword) async {
    logInfo('_login $theEmail $thePassword');
    try {
      bool a = await userController.getUser(theEmail, thePassword);
      if (!a) {
        Get.snackbar(
          "Correo o contraseña",
          "Invalida",
          icon: const Icon(Icons.person, color: Colors.blue),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Inicio de sesión",
                      style: TextStyle(fontSize: 40),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controllerEmail,
                      decoration: const InputDecoration(
                        labelText: "Email address",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        } else if (!value.contains('@')) {
                          return "Enter valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: controllerPassword,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        } else if (value.length < 6) {
                          return "Password should have at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                        FocusScope.of(context).requestFocus(FocusNode());
                        final form = _formKey.currentState;
                        form!.save();
                        if (_formKey.currentState!.validate()) {
                          await _login(
                              controllerEmail.text, controllerPassword.text);
                          opGenController.generateRandomOperation();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // establece la forma del botón
                        ),
                        textStyle: const TextStyle(
                          color: Colors
                              .black, // establece el color del texto del botón
                          fontSize:
                              20, // establece el tamaño de fuente del texto del botón
                        ),
                      ),
                      child: const Text("Submit"),
                    ),
                  ]),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // establece la forma del botón
                  ),
                  textStyle: const TextStyle(
                    color:
                        Colors.black, // establece el color del texto del botón
                    fontSize: 20,
                  ),
                ),
                child: const Text("Create account"))
          ],
        ),
      ),
    );
  }
}

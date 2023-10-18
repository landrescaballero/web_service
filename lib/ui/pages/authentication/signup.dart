import 'package:f_web_authentication/domain/models/user.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../controller/authentication_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _FirebaseSignUpState();
}

class _FirebaseSignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: 'a@a.com');
  final controllerPassword = TextEditingController(text: '123456');
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerBirthDate = TextEditingController();
  final controllerCourse = TextEditingController();
  AuthenticationController authenticationController = Get.find();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign Up Information",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: controllerEmail,
                          decoration:
                              const InputDecoration(labelText: "Email address"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              logError('SignUp validation empty email');
                              return "Enter email";
                            } else if (!value.contains('@')) {
                              logError('SignUp validation invalid email');
                              return "Enter valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerPassword,
                          decoration:
                              const InputDecoration(labelText: "Password"),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            } else if (value.length < 6) {
                              return "Password should have at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerFirstName,
                          decoration:
                              const InputDecoration(labelText: "First Name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter first name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerLastName,
                          decoration:
                              const InputDecoration(labelText: "Last Name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter last name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerBirthDate,
                          decoration:
                              const InputDecoration(labelText: "Birth Date"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter birth date";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controllerCourse,
                          decoration:
                              const InputDecoration(labelText: "Course"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter course";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () async {
                              final form = _formKey.currentState;
                              form!.save();
                              // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                logInfo('SignUp validation form ok');
                                await userController.addUser(User(
                                    email: controllerEmail.text,
                                    firstName: controllerFirstName.text,
                                    lastName: controllerLastName.text,
                                    birthday: controllerBirthDate.text,
                                    course: controllerCourse.text,
                                    password: controllerPassword.text,
                                    difficult: "1"));
                                Get.back();
                              } else {
                                logError('SignUp validation form nok');
                              }
                            },
                            child: const Text("Submit")),
                      ]),
                ))));
  }
}

import 'package:f_web_authentication/data/datasources/remote/models/some_data_db.dart';
import 'package:f_web_authentication/data/local_history_source.dart';
import 'package:f_web_authentication/domain/use_case/user_usecase.dart';
import 'package:f_web_authentication/ui/central.dart';
import 'package:f_web_authentication/ui/controller/history_controller.dart';
import 'package:f_web_authentication/ui/controller/local_controller.dart';
import 'package:f_web_authentication/ui/controller/op_gen_controller.dart';
import 'package:f_web_authentication/ui/controller/operation_controller.dart';
import 'package:f_web_authentication/ui/controller/player_controller.dart';
import 'package:f_web_authentication/ui/controller/time_controller.dart';
import 'package:f_web_authentication/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loggy/loggy.dart';

import 'data/datasources/remote/history_datasource.dart';
import 'data/datasources/remote/models/local_history.dart';
import 'data/local_data_source.dart';
import 'domain/repositories/repository.dart';
import 'ui/controller/difficulty_controller.dart';

Future<List<Box>> _openBoxes() async {
  List<Box> boxList = [];
  await Hive.initFlutter();
  Hive.registerAdapter(SomeDataAdapter());
  boxList.add(await Hive.openBox('user'));
  Hive.registerAdapter(LocalHistorialAdapter());
  boxList.add(await Hive.openBox('history'));
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBoxes();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put(PlayerController());
  Get.put(Repository());
  Get.put(LocalDataSource());
  Get.put(HistorySource());
  Get.put(Localhistory());
  Get.put(UserUseCase());
  Get.put(Local_controller());
  Get.put(UserController());
  Get.put(HistoryController());
  Get.put(TimerController());
  Get.put(DifficultyController());
  Get.put(OperationController());
  Get.put(OperationGeneratorController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Practicas Matematicas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Central(),
    );
  }
}

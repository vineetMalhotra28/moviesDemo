import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_demo/services/database_helper.dart';
import 'package:movies_demo/services/route.dart';

import 'screens/home_screen.dart';

final dbHelper = DatabaseHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies Demo',
      initialRoute: "/",
      getPages: Routes().route,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

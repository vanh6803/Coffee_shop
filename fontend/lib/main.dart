import 'package:flutter/material.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:fontend/views/home/home.dart';
import 'package:fontend/views/login/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if a token exists in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp(this.isLoggedIn, {super.key});
  final _themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: _themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: isLoggedIn ? Home() : Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

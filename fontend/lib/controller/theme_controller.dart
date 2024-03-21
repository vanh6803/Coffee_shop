import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  ThemeData currentTheme = ThemeData.light();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    currentTheme = isDarkMode.value ? ThemeData.dark() : ThemeData.light();
    Get.changeTheme(currentTheme);
    update();
  }

  // void _updateSystemTheme() {
  //   Brightness systemTheme = Get.theme.brightness;
  //   if(systemTheme == Brightness.light){
  //     isDarkMode.value = false;
  //   }else{
  //     isDarkMode.value = true;
  //   }
  // }


}

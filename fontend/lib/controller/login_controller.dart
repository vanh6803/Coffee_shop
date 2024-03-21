import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fontend/api/api_url.dart';
import 'package:fontend/utils/cache.dart';
import 'package:fontend/views/home/home.dart';
import 'package:fontend/views/register/register.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  RxBool hidePassword = true.obs;

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final response = await http.post(
          Uri.parse(LOGIN_URL),
          body: {'email': email, 'password': password},
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        if(response.statusCode == 200){
          print('login successful');
          final String token = responseData['token'];

          await AppCache.saveTokenToCache(token);

          clearForm();

          Get.offAll(()=>Home());

        }else{
          Get.snackbar(
            'Error',
            responseData["message"],
            icon: const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
            ),
            backgroundColor: Colors.black54,
            colorText: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void goToRegister(){
    clearForm();
    Get.to(Register());
  }

  void clearForm(){
    formKey.currentState?.reset();
    emailController.text = '';
    passwordController.text = '';
  }

}

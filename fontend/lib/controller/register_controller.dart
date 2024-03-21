import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fontend/api/api_url.dart';
import 'package:fontend/views/login/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool hidePassword = true.obs;
  RxBool hidePasswordConfirm = true.obs;

  RxBool isLoading = false.obs;

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
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? confirmPasswordValidator(String value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void toggleShowPassword() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleShowConfirmPassword() {
    hidePasswordConfirm.value = !hidePasswordConfirm.value;
  }

  Future<void> register(String email, String password) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;

        // Gọi API để đăng ký
        final response = await http.post(
          Uri.parse(REGISTER_URL),
          body: {'email': email, 'password': password},
        );

        isLoading.value = false;
        if (response.statusCode == 201) {
          Get.snackbar(
            'Success',
            'User registered successfully',
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.greenAccent,
            ),
            backgroundColor: Colors.black54,
            colorText: Colors.greenAccent,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          clearForm();
          Get.to(Login());
        } else {
          // Xử lý kết quả thất bại
          print('Đăng ký thất bại ${response.body}');
          final Map<String, dynamic> errorBody = json.decode(response.body);
          final errorMessage = errorBody['message'] ?? 'Registration failed';

          Get.snackbar(
            'Error',
            errorMessage,
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
      } catch (error) {
        // Xử lý lỗi
        isLoading.value = false;
        print('Lỗi: $error');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void backPage() {
    clearForm();
    Get.back();
  }

  void clearForm(){
    formKey.currentState?.reset();
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }
}

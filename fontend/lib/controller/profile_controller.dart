import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fontend/api/api_url.dart';
import 'package:fontend/models/user.dart';
import 'package:fontend/utils/cache.dart';
import 'package:fontend/views/login/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  RxBool isLoading = false.obs;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      String? token = await AppCache.getTokenFromCache();

      if (token != null) {
        final response = await http.get(
          Uri.parse(PROFILE_URL),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        isLoading.value = false;
        if (response.statusCode == 200) {
          user.value = User.fromJson(responseData["result"]);
          usernameController.text = user.value!.username!;
          emailController.text = user.value!.email!;
        } else {
          print('fail ${response.body}');
        }
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
  }

  Future<String> updateProfile() async {
    try {
      isLoading.value = true;
      String? token = await AppCache.getTokenFromCache();

      if (token != null) {
        final response = await http.put(
          Uri.parse(PROFILE_URL),
          body: json.encode({
            "username": usernameController.text
          }),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        isLoading.value = false;
        print(responseData);
        if (response.statusCode == 201) {
          return "success";
        } else {
          return "fail ${response.body}";
        }
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
      return "Error: $e";
    }
    return "Unknown Error";
  }
  Future<String> updateEmail() async {
    try {
      isLoading.value = true;
      String? token = await AppCache.getTokenFromCache();

      if (token != null) {
        final response = await http.put(
          Uri.parse("$PROFILE_URL/change-email"),
          body: json.encode({
            "email": emailController.text,
          }),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        isLoading.value = false;
        print(responseData);
        if (response.statusCode == 201) {
          return "success";
        }if(response.statusCode == 409) {
          return "email already exists";
        }else {
          return "fail ${response.body}";
        }
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
      return "Error: $e";
    }
    return "Unknown Error";
  }

  Future<void> logout() async {
    String? token = await AppCache.getTokenFromCache();
    final response = await http.get(Uri.parse(LOGOUT_URL), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      Get.offAll(() => Login());
    } else {
      print(response.statusCode);
    }
  }
}

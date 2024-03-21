import 'dart:convert';

import 'package:fontend/api/api_url.dart';
import 'package:fontend/models/user.dart';
import 'package:fontend/utils/cache.dart';
import 'package:fontend/views/login/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      String? token = await AppCache.getTokenFromCache();

      if (token != null) {
        final response = await http.get(
          Uri.parse(PROFILE_URL), // Replace with your API endpoint
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        isLoading.value = false;
        print(responseData);
        if (response.statusCode == 200) {
          print("success");
          user.value = User.fromJson(responseData["result"]);
          print('${user.value.toString()}');
        } else {
          print('fail ${response.body}');
        }
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
  }

  Future<void> logout() async {
    String? token = await AppCache.getTokenFromCache();
    final response = await http.get(Uri.parse(LOGOUT_URL), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      Get.offAll(() => Login());
    } else {
      print(response.statusCode);
    }
  }
}

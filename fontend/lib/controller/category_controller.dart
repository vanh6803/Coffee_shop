
import 'dart:convert';

import 'package:fontend/api/api_url.dart';
import 'package:fontend/models/category.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController{

  var categories = [].obs;

  RxBool isLoading = false.obs;

  var selectedCategoryIndex = RxInt(0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(CATEGORY_URL));
    isLoading.value = true;

    if (response.statusCode == 200) {
      isLoading.value = false;
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> result = data['result'];
      categories.assignAll(result);
    } else {
      isLoading.value = false;
      print(response.body);
    }
  }

}
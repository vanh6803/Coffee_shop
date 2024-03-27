import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fontend/api/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {

  var listProduct = [].obs;
  var filteredProducts = [].obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var response = await http.get(Uri.parse(PRODUCT_URL));
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> result = responseData['result'];
      listProduct.assignAll(result);
    }else{
      print('Error fetching data: ${response.statusCode}');
    }
  }

  void filterProducts() {
    final query = searchController.text.toLowerCase();
    filteredProducts.value = listProduct.where((product) {
      return product['name'].toLowerCase().contains(query);
    }).toList();
    update();
  }
  
}
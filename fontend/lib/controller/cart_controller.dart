import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fontend/api/api_url.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/models/cart.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/utils/cache.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController{

  var cartItem = [].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    String? token = await AppCache.getTokenFromCache();
    isLoading.value = true;
    final response = await http.get(Uri.parse(CART_URL),   headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },);

    if (response.statusCode == 200) {
      isLoading.value = false;
      List<dynamic> jsonResponse = json.decode(response.body);
      cartItem.assignAll(jsonResponse.map((item) => Cart.fromJson(item)));
      print(cartItem);
    } else {
      isLoading.value = false;
      print(response.body);
    }
  }

  Future<void> addToData(Product product, String size ) async {
    String? token = await AppCache.getTokenFromCache();
    try {
      final response = await http.post(
        Uri.parse(CART_URL),
        body: json.encode({
          'productId': product.id,
          'size': size,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        await fetchData();
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteCartItem(String cartId) async {
    String? token = await AppCache.getTokenFromCache();
    try {
      final response = await http.delete(
        Uri.parse('$CART_URL/$cartId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 204) {
        print('Item deleted successfully');
        await fetchData();
      } else {
        throw Exception('Failed to delete item from cart');
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
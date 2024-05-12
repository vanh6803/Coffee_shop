import 'dart:convert';

import 'package:fontend/api/api_url.dart';
import 'package:fontend/models/cart.dart';
import 'package:fontend/models/order.dart';
import 'package:fontend/utils/cache.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  var orders = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchOrder("All");
  }

  Future<void> orderCoffee(List<Cart> carts) async {
    String? token = await AppCache.getTokenFromCache();
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(ORDER_URL),
        body: json.encode({"productOrder": carts}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        print("success");
        fetchOrder("All");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> changeStatusOrder(String id, String status) async {
    String? token = await AppCache.getTokenFromCache();
    isLoading.value = true;
    try {
      final response = await http.put(
        Uri.parse("$ORDER_URL/$id"),
        body: json.encode({"status": status}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        print("success");
        fetchOrder("In progress");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrder(String? query) async {
    String? token = await AppCache.getTokenFromCache();
    isLoading.value = true;

    String uri;
    if (query == "Pending" || query == "In progress" || query == "Success" ||query == "Canceled") {
      uri = "$ORDER_URL?status=$query";
    } else {
      uri = ORDER_URL;
    }

    try {
      final response = await http.get(Uri.parse(uri), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        orders.assignAll(jsonResponse.map((e) => Order.fromJson(e)));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

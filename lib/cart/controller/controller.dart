import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final isProductsLoading = false.obs;
  final cartList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartDetails();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   fetchCartDetails();
  // }

  Future<void> fetchCartDetails() async {
    try {
      isProductsLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> jsonStringList = prefs.getStringList('cart') ?? [];

      // Decode strings into Maps and assign directly to the observable list
      cartList.value = jsonStringList.map((stringItem) {
        return jsonDecode(stringItem) as Map<String, dynamic>;
      }).toList();

      log('Loaded ${cartList.length} unique items into CartController.');
    } catch (e) {
      log('Error reading cart data: $e');
    } finally {
      isProductsLoading.value = false;
    }
  }

  void clearCartData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    cartList.clear(); // Clear the observable list as well
    log('Cart wiped clean!');
  }
}

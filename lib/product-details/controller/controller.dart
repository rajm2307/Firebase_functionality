import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:demo_project/product-details/helper/helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Details {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Details({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'] is double
        ? json['price']
        : (json['price'] as num).toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = (json['rate'] as num).toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}

class ProductDetailsController extends GetxController {
  final isProductsDetailsLoading = false.obs;
  final addToCartLoading = false.obs;
  final details = Rxn<Details>();
  final productQuantity = 1.obs;

  Future<void> fetchProductDetails(int productId) async {
    try {
      isProductsDetailsLoading.value = true;

      final productDetails = await ProductDetails.fetchProductDetails(
        productId,
      );

      // details.assignAll(productDetails);
      details.value = productDetails;
    } catch (e) {
      log('Error fetching products: $e');
    } finally {
      isProductsDetailsLoading.value = false;
    }
  }

  void quantityOperator(String operator) {
    if (operator == 'increment') {
      productQuantity.value++;
    } else if (operator == 'decrement' && productQuantity.value > 1) {
      productQuantity.value--;
    }
  }

  void addToCart(Details product, int quantity) async {
    try {
      addToCartLoading.value = true;
      final prefs = await SharedPreferences.getInstance();

      List<String> cartItemsStrings = prefs.getStringList('cart') ?? [];

      List<Map<String, dynamic>> cartList = cartItemsStrings
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();

      bool isItemFound = false;

      for (var item in cartList) {
        if (item['product']['id'] == product.id) {
          // If found, increment its existing quantity
          log('Product already in cart. Incrementing quantity.');
          item['quantity'] = (item['quantity'] as int) + quantity;
          isItemFound = true;
          break;
        }
      }

      if (!isItemFound) {
        cartList.add({'product': product.toJson(), 'quantity': quantity});
      }

      List<String> updatedStringList = cartList
          .map((item) => jsonEncode(item))
          .toList();

      await prefs.setStringList('cart', updatedStringList);
      addToCartLoading.value = false;

      log('Product successfully added/updated in local cart storage!');
      log('Current cart contents: $cartList');
    } catch (e) {
      log('Failed to save cart item: $e');
    } finally {
      addToCartLoading.value = false;
    }
  }
}

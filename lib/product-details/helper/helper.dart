import 'dart:convert';
import 'dart:developer';

import 'package:demo_project/core/api-routes/api-routes.dart';
 import 'package:http/http.dart' as http;
import 'package:demo_project/product-details/controller/controller.dart';

class ProductDetails {
  static Future<Details> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('${ApiRoutes.productDetails}/$productId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log('Product details fetched successfully: ${response.body}');
      return  Details.fromJson(jsonData);
    } else {
      throw Exception(
        'Failed to fetch product details. Status code: ${response.statusCode}',
      );
    }
  }
}

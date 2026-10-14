import 'dart:convert';
import 'dart:developer';

import 'package:demo_project/core/api-routes/api-routes.dart';
import 'package:demo_project/homepage/controller/controller.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiRoutes.allProducts));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log('Products fetched successfully: ${response.body}');
      return jsonData.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to fetch products. Status code: ${response.statusCode}',
      );
    }
  }

  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse(ApiRoutes.categories));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log('Categories fetched successfully: ${response.body}');
      return List<String>.from(jsonData);
    } else {
      throw Exception(
        'Failed to fetch Categories. Status code: ${response.statusCode}',
      );
    }
  }

    static Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('${ApiRoutes.fetchedCategoryProducts}/$category'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log('Filtered products fetched successfully: ${response.body}');
      return jsonData.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to fetch Filtered products. Status code: ${response.statusCode}',
      );
    }
  }
}
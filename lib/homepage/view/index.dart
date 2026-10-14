import 'dart:developer';

import 'package:demo_project/auth/view/index.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:demo_project/cart/view/index.dart';
import 'package:demo_project/homepage/controller/controller.dart';
import 'package:demo_project/product-details/view/index.dart';

class Homepage extends GetView<HomepageController> {
  static const String name = 'homepage';
  const Homepage({super.key});

  Future<void> _logout(BuildContext context) async {
    final success = await controller.logout();
    if (success && context.mounted) {
      context.goNamed(Loginpage.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Homepage'),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.pushNamed(Cartpage.name);
              },
            ),

            // logout button
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(context),
            ),

            // IconButton(
            //   icon: const Icon(Icons.bug_report),
            //   onPressed: () => FirebaseCrashlytics.instance.crash(),
            // ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchCategories();
          await controller.fetchProducts();
        },
        child: Column(
          children: [
            // Categories
            Obx(() {
              if (controller.isCategoriesLoading.value) {
                return const SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          controller.fetchProductsByCategory(category);
                        },
                        child: Obx(() {
                          final isSelected =
                              controller.selectedCategory.value == category;
                          return Chip(
                            label: Text(category),
                            backgroundColor: isSelected
                                ? Colors.blue
                                : Colors.white,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              );
            }),

            // Products
            Expanded(
              child: Obx(() {
                if (controller.isProductsLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];

                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          ProductDetails.name,
                          extra: {'productId': product.id},
                        );
                        log('Product ID: ${product.id}');
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(
                              product.image,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('\$${product.price}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
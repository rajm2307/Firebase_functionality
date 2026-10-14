
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:demo_project/cart/controller/controller.dart';
import 'package:demo_project/product-details/view/index.dart';

class Cartpage extends GetView<CartController> {
  static const String name = 'cartpage';
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCartDetails();
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Cart'),

            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   onPressed: () {
            //     controller.fetchCartDetails();
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                controller.clearCartData();
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchCartDetails();
        },
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isProductsLoading.value) {
                  return const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.cartList.isEmpty) {
                  return const Center(child: Text('Your cart is empty.'));
                }

                return ListView.builder(
                  itemCount: controller.cartList.length,
                  itemBuilder: (context, index) {
                    final cartItem = controller.cartList[index];
                    final product = cartItem['product'];
                    final quantity = cartItem['quantity'];

                    return ListTile(
                      leading: Image.network(product['image']),
                      title: Text(product['title']),
                      subtitle: Text('Quantity: $quantity'),
                      trailing: Text(
                        '\$${(product['price'] * quantity).toStringAsFixed(2)}',
                      ),
                      onTap: () {
                        // Navigate to product details page
                        context.pushNamed(
                          ProductDetails.name,
                          extra: {'productId': product['id']},
                        );
                      },
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


// [log] Current cart contents: [{product: {id: 6, title: Solid Gold Petite Micropave , price: 168.0, description: Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days., category: jewelery, image: https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_t.png, rating: {rate: 3.9, count: 70}}, quantity: 2}, {product: {id: 1, title: Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops, price: 109.95, description: Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday, category: men's clothing, image: https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png, rating: {rate: 3.9, count: 120}}, quantity: 3}, {product: {id: 1, title: Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops, price: 109.95, description: Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday, category: men's clothing, image: https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png, rating: {rate: 3.9, count: 120}}, quantity: 1}, {product: {id: 1, title: Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops, price: 109.95, description: Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday, category: men's clothing, image: https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png, rating: {rate: 3.9, count: 120}}, quantity: 6}, {product: {id: 1, title: Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops, price: 109.95, description: Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday, category: men's clothing, image: https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png, rating: {rate: 3.9, count: 120}}, quantity: 10}]
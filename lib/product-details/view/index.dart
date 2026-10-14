import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:demo_project/product-details/controller/controller.dart';

class ProductDetails extends GetView<ProductDetailsController> {
  static const String name = 'product-details';

  final int? productId;
  const ProductDetails({super.key, this.productId});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductDetails(productId!);
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Obx(() {
        if (controller.isProductsDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final details = controller.details.value;
        if (details == null) {
          return const Center(child: Text('No product details available.'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(details.image ?? ''),
                const SizedBox(height: 16),
                Text(
                  details.title ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${details.price?.toStringAsFixed(2) ?? ''}',
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 8),
                Text(details.description ?? ''),
                const SizedBox(height: 8),
                Text('Category: ${details.category ?? ''}'),
                const SizedBox(height: 8),
                if (details.rating != null)
                  Text(
                    'Rating: ${details.rating!.rate?.toStringAsFixed(1) ?? ''} (${details.rating!.count ?? 0} reviews)',
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.quantityOperator('decrement');
                      },
                      child: const Icon(Icons.remove),
                    ),

                    const SizedBox(width: 8),
                    Obx(
                      () => Text('${controller.productQuantity.value}'),
                    ), // Display the current quantity here
                    ElevatedButton(
                      onPressed: () {
                        controller.quantityOperator('increment');
                      },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 16),

                    ElevatedButton(
                      onPressed: () {
                        // Handle add to cart logic here
                        controller.addToCart(
                          details,
                          controller.productQuantity.value,
                        );
                      },
                      child: Obx(
                        () => controller.addToCartLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// {"id":20,"title":"DANVOUY Womens T Shirt Casual Cotton Short","price":12.99,"description":"95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.","category":"women's clothing","image":"https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_t.png","rating":{"rate":3.6,"count":145}}

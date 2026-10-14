import 'package:get/get.dart';
import 'package:demo_project/cart/controller/controller.dart';

class CartPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
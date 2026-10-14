import 'package:get/get.dart';
import 'package:demo_project/auth/controller/controller.dart';
 
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
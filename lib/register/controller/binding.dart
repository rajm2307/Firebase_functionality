import 'package:get/get.dart';
import 'package:demo_project/register/controller/controller.dart';
 
class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
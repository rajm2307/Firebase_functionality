import 'package:get/get.dart';
import 'package:demo_project/homepage/controller/controller.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(
      () => HomepageController(),
    );
  }
}
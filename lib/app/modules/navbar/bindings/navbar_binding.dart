import 'package:cafe_cirebon/app/modules/home/controllers/home_controller.dart';
import 'package:cafe_cirebon/app/modules/radar/controllers/radar_controller.dart';
import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
      Get.lazyPut<RadarController>(
      () => RadarController(),
    );
  }
}

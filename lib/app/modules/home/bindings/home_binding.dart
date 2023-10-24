import 'package:cafe_cirebon/app/utils/location_service.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LocationService>(
      () => LocationService(),
    );
  }
}

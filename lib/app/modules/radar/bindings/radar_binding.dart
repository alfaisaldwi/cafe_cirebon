import 'package:get/get.dart';

import '../controllers/radar_controller.dart';

class RadarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RadarController>(
      () => RadarController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/cafe_detail_controller.dart';

class CafeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeDetailController>(
      () => CafeDetailController(),
    );
  }
}

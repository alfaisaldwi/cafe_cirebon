import 'package:get/get.dart';

import '../modules/cafe_detail/bindings/cafe_detail_binding.dart';
import '../modules/cafe_detail/bindings/cafe_detail_binding.dart';
import '../modules/cafe_detail/views/cafe_detail_view.dart';
import '../modules/cafe_detail/views/cafe_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CAFE_DETAIL,
      page: () => const CafeDetailView(),
      binding: CafeDetailBinding(),
      children: [
        GetPage(
          name: _Paths.CAFE_DETAIL,
          page: () => const CafeDetailView(),
          binding: CafeDetailBinding(),
        ),
      ],
    ),
  ];
}

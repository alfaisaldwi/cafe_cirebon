import 'package:get/get.dart';

import '../modules/area/bindings/area_binding.dart';
import '../modules/area/views/area_view.dart';
import '../modules/cafe_detail/bindings/cafe_detail_binding.dart';
import '../modules/cafe_detail/views/cafe_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/radar/bindings/radar_binding.dart';
import '../modules/radar/views/radar_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NAVBAR;

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
    GetPage(
      name: _Paths.AREA,
      page: () => const AreaView(),
      binding: AreaBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => BasicMainNavigationView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.RADAR,
      page: () => const RadarView(),
      binding: RadarBinding(),
    ),
  ];
}

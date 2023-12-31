import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_cirebon/app/modules/navbar/views/navbar_view.dart';
import 'package:cafe_cirebon/app/style/color_primary.dart';
import 'package:cafe_cirebon/app/utils/location_service.dart';
import 'package:cafe_cirebon/app/widgets/drawer.dart';
import 'package:cafe_cirebon/app/widgets/search_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Center(
            child: GestureDetector(
              onTap: () {
                SearchWidget.showCustomSearch(context, controller.cafeData);
              },
              child: Row(
                children: [
                  SearchForm(
                    width: MediaQuery.sizeOf(context).width * 0.66,
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Styles.colorPrimary(),
                    size: 22,
                  ),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Styles.colorPrimary(),
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          ),
        ],
      ),
      endDrawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          // controller.reFetch();
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Styles.colorPrimary(),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.currentAddress.value.isNotEmpty
                                  ? ' ${controller.currentAddress.value}'
                                  : 'Mencari lokasi...',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.refresh_outlined),
                              color: Styles.colorPrimary(),
                              onPressed: () => controller.callLocationService(),
                            ),
                          ],
                        ),
                      )),
                  Card(
                    elevation: 0.0,
                    child: Stack(alignment: Alignment.center, children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Obx(() {
                            return Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.25,
                                    onPageChanged: (index, reason) {
                                      controller.currentCaraousel.value = index;
                                    },
                                  ),
                                  items: controller.caraosel.map((carousel) {
                                    return CachedNetworkImage(
                                      imageUrl: carousel,
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        width: 600,
                                        alignment: Alignment.center,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.image_not_supported_rounded,
                                        color: Colors.grey,
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Center(
                                  child: controller.caraosel.isEmpty
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.caraosel
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () => controller.controllerCaraousel
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 6.0,
                                  height: 6.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Styles.colorPrimary()
                                              : Colors.black)
                                          .withOpacity(
                                              controller.currentCaraousel ==
                                                      entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                    ]),
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cafe di area',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraint) {
                          List menus = [
                            {
                              "icon":
                                  "https://cdn-icons-png.flaticon.com/512/12412/12412162.png",
                              "label": "Cirebon Kota",
                              "onTap": () {},
                            },
                            {
                              "icon":
                                  "https://cdn-icons-png.flaticon.com/512/4721/4721028.png",
                              "label": "Cirebon Barat",
                              "onTap": () {},
                            },
                            {
                              "icon":
                                  "https://cdn-icons-png.flaticon.com/512/12482/12482664.png",
                              "label": "Cirebon Timur",
                              "onTap": () {},
                            },
                            {
                              "icon":
                                  "https://cdn-icons-png.flaticon.com/512/12412/12412146.png",
                              "label": "Cirebon Utara",
                              "onTap": () {},
                            },
                          ];

                          return Wrap(
                            children: List.generate(
                              menus.length,
                              (index) {
                                var item = menus[index];

                                var size = constraint.biggest.width / 4;

                                return SizedBox(
                                  width: size,
                                  height: size,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.blueGrey,
                                      animationDuration:
                                          const Duration(milliseconds: 1000),
                                      backgroundColor: Colors.transparent,
                                      splashFactory: InkSplash.splashFactory,
                                      shadowColor: Colors.transparent,
                                      elevation: 0.0,
                                    ),
                                    onPressed: () {
                                      Get.toNamed('area');
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          item["icon"],
                                          width: 30.0,
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Text(
                                          "${item["label"]}",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 6.0, left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Saran cafe untukmu',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.cafeData.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 20,
                            children: List.generate(6, (index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ));
                            })),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 10),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.cafeData.length,
                          itemBuilder: (context, index) {
                            var cafe = controller.cafeData[index];
                            return GestureDetector(
                              onTap: () async {
                                // var productDetails = await controller
                                //     .fetchProductDetails(product.id);
                                Get.toNamed(
                                  'cafe-detail',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                ),
                                child: Card(
                                  elevation: 2,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   color: Styles.colorPrimary(),
                                      //   width: 1,
                                      // ),
                                      borderRadius: BorderRadius.circular(14.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65 *
                                                  (3 / 4),
                                              child: CachedNetworkImage(
                                                imageUrl: cafe['photos'].first,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                    child: Image(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      width: double
                                                          .infinity, // Explicit width
                                                      height: double
                                                          .infinity, // Explicit height
                                                      color: Colors
                                                          .deepOrange[400],
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons
                                                      .image_not_supported_rounded,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${cafe['name']} asdadsadassdasadasdsadasdasd wda",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(cafe['district'],
                                                      style: const TextStyle(
                                                          fontSize: 14)),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    cafe['openingHours'],
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(
                                                          133, 133, 133, 1),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

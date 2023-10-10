import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_cirebon/app/utils/convertToIdr.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:search_page/search_page.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // showSearch(
                  //   context: context,
                  //   delegate: SearchPage(
                  //     barTheme: ThemeData.light(useMaterial3: true),
                  //     onQueryUpdate: print,
                  //     items: controller.products,
                  //     searchLabel: 'Cari..',
                  //     suggestion: const Center(
                  //       child: Text('Cari produk yang kamu kebutuhan'),
                  //     ),
                  //     failure: const Center(
                  //       child: Text('Produk yang kamu cari tidak ada :('),
                  //     ),
                  //     filter: (product) {
                  //       return [
                  //         product.title,
                  //       ];
                  //     },
                  //     builder: (product) => SearchView(
                  //       products: product,
                  //     ),
                  //   ),
                  // );
                },
                child: Row(
                  children: [
                    Container(
                      width: 240,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const TextField(
                        enabled: false,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                          border: InputBorder
                              .none, // Hapus border pada input decoration TextField
                          hintText: 'Cari Produk',
                          hintStyle: TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: GestureDetector(
                onTap: () {
                  // String? token = GetStorage().read('token');
                  // if (token != null) {
                  //   Get.toNamed('/cart');
                  //   // Get.toNamed('/payment');
                  // } else {
                  //   Fluttertoast.showToast(
                  //     msg: 'Silahkan Signin terlebih dahulu',
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM,
                  //     backgroundColor: Colors.grey[800],
                  //     textColor: Colors.white,
                  //     fontSize: 14.0,
                  //   );
                  //   Get.toNamed('/profile');
                  // }
                },
                child: const Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.black,
                  size: 22,
                ),
              ),
              onPressed: () {},
            ),
          ]),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0.0,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Obx(() => CarouselSlider(
                                options: CarouselOptions(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    autoPlay: true,
                                    viewportFraction: 0.97,
                                    aspectRatio: 16 / 9),
                                items: controller.caraosel.map((carousel) {
                                  return Container(
                                    child: CachedNetworkImage(
                                      imageUrl: carousel,
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth,
                                        width: 600,
                                        alignment: Alignment.center,
                                      ),
                                      placeholder: (context, url) => Center(
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: Container(
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ))),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.image_not_supported_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kategori',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1 + 3,
                          width: MediaQuery.of(context).size.width * .9,
                          child: Obx(() => ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.cafeData.length,
                              itemBuilder: (context, index) {
                                var district = controller.cafeData[index];

                                return GestureDetector(
                                  onTap: () async {
                                    // var categoryDetail = await controller
                                    //     .categotyDetail(category.id);
                                    // print(category.id);

                                    // Get.toNamed('category', arguments: [
                                    //   categoryDetail,
                                    //   category.title
                                    // ]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, bottom: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 80,
                                              width: 60,
                                              child: Column(
                                                children: [
                                                  // CachedNetworkImage(
                                                  //   imageUrl: ca,
                                                  //   imageBuilder: (context,
                                                  //           imageProvider) =>
                                                  //       Image(
                                                  //     image: imageProvider,
                                                  //     width: 43,
                                                  //     height: 43,
                                                  //     fit: BoxFit.fill,
                                                  //     alignment:
                                                  //         Alignment.center,
                                                  //   ),
                                                  //   placeholder:
                                                  //       (context, url) =>
                                                  //           Center(
                                                  //     child:
                                                  //         LoadingAnimationWidget
                                                  //             .flickr(
                                                  //       rightDotColor: Colors
                                                  //           .grey.shade200,
                                                  //       leftDotColor:
                                                  //           const Color(
                                                  //               0xfffd0079),
                                                  //       size: 25,
                                                  //     ),
                                                  //   ),
                                                  //   errorWidget:
                                                  //       (context, url, error) =>
                                                  //           const Icon(
                                                  //     Icons
                                                  //         .image_not_supported_rounded,
                                                  //     color: Colors.grey,
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        district['district'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Saran kafe untukmu',
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
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
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
                                // Get.toNamed('product-detail',
                                //     arguments: [productDetails]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cafe['name'],
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(cafe['district'],
                                                  style: const TextStyle(
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8 *
                                                  (3 / 4),
                                              child: CachedNetworkImage(
                                                imageUrl: cafe['photos'].first,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        ClipRRect(
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
                                                horizontal: 2,
                                                vertical: 5,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          cafe['openingHours'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromRGBO(
                                                                    133,
                                                                    133,
                                                                    133,
                                                                    1),
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

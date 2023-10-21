import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_cirebon/app/modules/home/controllers/home_controller.dart';
import 'package:cafe_cirebon/app/style/color_primary.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/cafe_detail_controller.dart';

class CafeDetailView extends GetView<CafeDetailController> {
  const CafeDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homeC = HomeController();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Styles.colorPrimary()),
          title: Text(
            'CAFE ',
            style: TextStyle(color: Styles.colorPrimary()),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Icon(
              Icons.favorite_outline,
              size: 22,
              color: Styles.colorPrimary(),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(() {
                return Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        height: MediaQuery.sizeOf(context).height * 0.42,
                        onPageChanged: (index, reason) {
                          homeC.currentCaraousel.value = index;
                        },
                      ),
                      items: homeC.caraosel.map((carousel) {
                        return CachedNetworkImage(
                          imageUrl: carousel,
                          imageBuilder: (context, imageProvider) => Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_not_supported_rounded,
                            color: Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                    Center(
                      child: homeC.caraosel.isEmpty
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                );
              }),
            ),
            Positioned(
              bottom: 1,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: homeC.caraosel.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () =>
                          homeC.controllerCaraousel.animateToPage(entry.key),
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
                                .withOpacity(homeC.currentCaraousel == entry.key
                                    ? 0.9
                                    : 0.4)),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
          ]),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  
              Text('Moocoow Cafe'),
              Text('Jl. Arya Kemuning'),
            ]),
          ),
        ]));
  }
}

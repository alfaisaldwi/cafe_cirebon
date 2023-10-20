import 'package:cafe_cirebon/app/model/cafe_model.dart';
import 'package:cafe_cirebon/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  CafeModel cafe;

  SearchView({required this.cafe});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(cafe.photos.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(cafe.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stok:  ${cafe.location}'),

                ],
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                // var productDetails =
                //     await controller.fetchProductDetails(products.id);
                // Get.toNamed('product-detail', arguments: [productDetails]);
              },
            ),
          ],
        ),
      ),
    );
  }
}



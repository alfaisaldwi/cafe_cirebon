import 'package:cafe_cirebon/app/model/cafe_kota_cirebon.dart';
import 'package:cafe_cirebon/app/style/color_primary.dart';
import 'package:cafe_cirebon/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/area_controller.dart';

class AreaView extends GetView<AreaController> {
  const AreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = districtKota.take(5).map((data) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Styles.colorPrimary(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Text(
            '${data['kecamatan']}',
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Styles.colorPrimary()),
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Center(
            child: GestureDetector(
              onTap: () {
                SearchWidget.showCustomSearch(
                    context, controller.HomeC.cafeData);
              },
              child: Row(
                children: [
                  SearchForm(
                    width: MediaQuery.sizeOf(context).width * 0.65,
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: Styles.colorPrimary(),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.start,
              children: buttons.sublist(0, 3),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.start,
              children: buttons.sublist(3),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Cafe Di Area Kota Cirebon',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

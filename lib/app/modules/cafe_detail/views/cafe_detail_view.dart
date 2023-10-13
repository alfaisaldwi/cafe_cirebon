import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cafe_detail_controller.dart';

class CafeDetailView extends GetView<CafeDetailController> {
  const CafeDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CafeDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CafeDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

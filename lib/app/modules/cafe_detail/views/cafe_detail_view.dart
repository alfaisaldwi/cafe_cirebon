import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cafe_detail_controller.dart';

class CafeDetailView extends GetView<CafeDetailController> {
  const CafeDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              title: new Text(
                "Hello World",
                style: TextStyle(color: Colors.amber),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: new Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

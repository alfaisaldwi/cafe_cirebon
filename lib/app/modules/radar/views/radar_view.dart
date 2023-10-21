import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';

import '../controllers/radar_controller.dart';

class RadarView extends GetView<RadarController> {
  const RadarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RadarView'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          List<Marker> allMarkers = [];

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: FlutterMap(
              options: MapOptions(enableScrollWheel: true),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                PolylineLayer(
                  polylines: [],
                ),
                MarkerLayer(
                  markers: allMarkers,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

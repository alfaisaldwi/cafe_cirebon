import 'package:cafe_cirebon/app/modules/home/controllers/home_controller.dart';
import 'package:cafe_cirebon/app/modules/radar/controllers/radar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:icons_plus/icons_plus.dart';

class RadarView extends StatefulWidget {
  RadarView({Key? key}) : super(key: key);

  @override
  State<RadarView> createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView> {
  final radarC = Get.put(RadarController());
  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>{
        const Marker(
            markerId: MarkerId('Shop'),
            position: LatLng(-6.723512, 108.560025),
            infoWindow: InfoWindow(title: 'soop'),
            icon: BitmapDescriptor.defaultMarker),
      };
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: Stack(children: [
        GoogleMap(
          markers: Set<Marker>.of(radarC.markers.values),
          initialCameraPosition: radarC.defaultLocation,
          mapType: radarC.currentMode,
          onMapCreated: (GoogleMapController controller) {
            radarC.mapController = controller;
          },
        ),
        Positioned(
          right: 10,
          bottom: 100,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(top: 24, right: 12),
            child: Column(children: [
              FloatingActionButton(
                backgroundColor: Colors.blueAccent,
                onPressed: radarC.changeMode,
                child: Icon(Icons.map, size: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: () async {
                  radarC.goDefaultLocation();
                },
                child: Icon(FontAwesome.location_dot, size: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: () async {
                  radarC.goCurrentLocation();
                },
                child: Icon(Iconsax.gps, size: 30),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}

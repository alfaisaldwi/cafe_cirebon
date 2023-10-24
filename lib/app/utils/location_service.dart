import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as Loc;
import 'package:permission_handler/permission_handler.dart';

class LocationService extends GetxController {
  RxString currentAddress = ''.obs;
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Loc.LocationData locationData = await Loc.Location().getLocation();
    } else if (status.isDenied) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Akses Lokasi Diperlukan'),
          content: Text(
              'Anda telah menolak izin lokasi. Buka pengaturan untuk mengizinkannya?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text('Buka Pengaturan'),
            ),
          ],
        ),
      );
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Akses Lokasi Diperlukan'),
          content: Text(
              'Anda telah menolak izin lokasi secara permanen. Buka pengaturan untuk mengizinkannya?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text('Buka Pengaturan'),
            ),
          ],
        ),
      );
    }
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      update();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        currentAddress.value =
            '${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}';
      } else {
        currentAddress.value = 'Lokasi tidak ditemukan';
      }
    } catch (e) {
      print('Tidak dapat mengakses lokasi: $e');
      currentAddress.value = 'Terjadi kesalahan';
    }
  }
}

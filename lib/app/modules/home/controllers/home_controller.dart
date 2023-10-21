import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as Loc;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  RxInt currentCaraousel = 0.obs;
  final RxString currentAddress = ''.obs;
  final CarouselController controllerCaraousel = CarouselController();

  List caraosel = [
    'https://radarcirebon.disway.id/upload/7ae51109cf523833c1f3f0e63be3c8de.PNG',
    'https://radarcirebon.disway.id//upload/ad43ddb6bd74d152485dc028b9d0f9d2.PNG'
  ].obs;
  List category = [].obs;
  RxList<Map<String, dynamic>> cafeData = <Map<String, dynamic>>[
    {
      'name': 'MooCow Fresh Milk',
      'location': '123 Main Street, City, Country',
      'district': 'Central District',
      'openingHours': '11:00 AM - 11:00 PM WIB',
      'photos': [
        'https://picsum.photos/id/237/200/300',
        'https://picsum.photos/seed/picsum/200/300'
      ],
      'description': 'Coffee House 1 is a cozy cafe with a great ambiance.',
      'phoneNumber': '+1234567890',
      'latitude': 123.456,
      'longitude': 78.901,
      'reviews': [
        {
          'senderName': 'John Doe',
          'comment': 'Great coffee and friendly staff!',
          'rating': 4.5,
          'date': '2023-10-01',
        },
        {
          'senderName': 'Jane Smith',
          'comment': 'Nice place to hang out.',
          'rating': 4.0,
          'date': '2023-09-28',
        },
      ],
    },
    {
      'name': 'Cafe 2',
      'location': '456 Elm Street, City, Country',
      'district': 'North District',
      'openingHours': '10:00 AM - 10:00 PM WIB',
      'photos': [
        'https://picsum.photos/200/300/?blur'
            'https://picsum.photos/seed/picsum/200/300',
      ],
      'description': 'Cafe 2 offers a variety of pastries and sandwiches.',
      'phoneNumber': '+9876543210',
      'latitude': 98.765,
      'longitude': 32.109,
      'reviews': [
        {
          'senderName': 'Alice Johnson',
          'comment': 'The pastries here are delicious!',
          'rating': 4.8,
          'date': '2023-10-05',
        },
        {
          'senderName': 'Bob Wilson',
          'comment': 'I love the coffee at Cafe 2.',
          'rating': 4.6,
          'date': '2023-09-30',
        },
      ],
    },
    // Add more cafes here as needed
  ].obs;

  final count = 0.obs;
  @override
  void onInit() {
    requestLocationPermission();
    getCurrentLocation();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

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
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
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

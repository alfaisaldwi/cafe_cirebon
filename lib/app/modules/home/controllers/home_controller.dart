import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List caraosel = ['https://radarcirebon.disway.id/upload/7ae51109cf523833c1f3f0e63be3c8de.PNG','https://radarcirebon.disway.id//upload/ad43ddb6bd74d152485dc028b9d0f9d2.PNG'];
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
}

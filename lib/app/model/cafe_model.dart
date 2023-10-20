class CafeModel {
  String name;
  String location;
  String district;
  String openingHours;
  List<String> photos;
  String description;
  String phoneNumber;
  double latitude;
  double longitude;
  List<Review> reviews;

  CafeModel({
    required this.name,
    required this.location,
    required this.district,
    required this.openingHours,
    required this.photos,
    required this.description,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.reviews,
  });
}

class Review {
  String senderName;
  String comment;
  double rating;
  String date;

  Review({
    required this.senderName,
    required this.comment,
    required this.rating,
    required this.date,
  });
}
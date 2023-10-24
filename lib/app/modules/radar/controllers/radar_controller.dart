import 'package:cafe_cirebon/app/modules/home/controllers/home_controller.dart';
import 'package:cafe_cirebon/app/utils/location_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RadarController extends GetxController {
  var locationC = LocationService();
  var homeC = HomeController();
  static const double defaultLat = -6.723512;
  static const double defaultLong = 108.560025;
  late GoogleMapController mapController;
  CameraPosition defaultLocation =
      CameraPosition(target: LatLng(defaultLat, defaultLong), zoom: 15);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MapType currentMode = MapType.normal;
  final Set<Marker> _point = {};

  void changeMode() {
    currentMode =
        currentMode == MapType.normal ? MapType.satellite : MapType.normal;
  }

  void goDefaultLocation() async {
    const _defaultPosition = LatLng(defaultLat, defaultLong);
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(_defaultPosition, 200));
    final point = Marker(
      markerId: MarkerId('Lokasi Awal'),
      position: _defaultPosition,
      infoWindow: InfoWindow(title: 'Lokasi Awal', snippet: 'ii'),
    );
    _point
      ..clear()
      ..add(point);
  }

  void goCurrentLocation() async {
    const _defaultPosition = LatLng(defaultLat, defaultLong);
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(_defaultPosition, 200));
    final point = Marker(
      markerId: MarkerId('Lokasi Awal'),
      position: LatLng(locationC.latitude,locationC.longitude),
      infoWindow: InfoWindow(title: 'Lokasi Awal', snippet: 'ii'),
    );
    _point
      ..clear()
      ..add(point);
  }

  void initMarker(Map<String, dynamic> specify, String specifyId) {
    var latitude = specify['latitude'] as double;
    var longitude = specify['longitude'] as double;

    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: '${specify['name']}',
        snippet: '${specify['location']}',
      ),
    );

    markers[markerId] = marker;
  }

  void getMarkerData() {
    for (int i = 0; i < homeC.cafeData.length; i++) {
      var cafe = homeC.cafeData[i];
      initMarker(cafe, cafe['id'].toString());
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    getMarkerData();
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

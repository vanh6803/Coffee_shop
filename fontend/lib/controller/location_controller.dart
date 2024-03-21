import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {

  var userLocation = Rx<Position?>(null);
  var userAddress = RxString('');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          print("User denied location permission");
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("Current position: $position");

      userLocation.value = position;

      // Lấy thông tin địa chỉ từ tọa độ
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        print("${placemark.subAdministrativeArea} ,${placemark.administrativeArea}");
        userAddress.value = "${placemark.subAdministrativeArea} ,${placemark.administrativeArea}" ?? '';
      } else {
        userAddress.value = 'Unknown Address';
      }
    } catch (e) {
      print("Error getting user location: $e");
    }
  }

}

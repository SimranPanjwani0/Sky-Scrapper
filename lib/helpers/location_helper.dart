// import 'dart:convert';
// import 'dart:developer';
// import 'package:geolocator/geolocator.dart';
// import 'package:getx_weather_app/modals/location_modal.dart';
// import 'package:http/http.dart' as http;
//
// class LocationHelper {
//   LocationHelper._();
//   static final LocationHelper lHelper = LocationHelper._();
//
//   Future<Location?> getLocationData(
//       {double lat = 21.170240, double lon = 72.831062}) async {
//     Location? location;
//
//     String locationApi =
//         "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=6866e0dac6bcd79835745d1bc0ec69b9";
//
//     http.Response response = await http.get(
//       Uri.parse(locationApi),
//     );
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       Location allData = Location.fromJson(json: data);
//       return allData;
//     }
//
//     log(response.statusCode as String);
//     return null;
//   }
//
//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
// }

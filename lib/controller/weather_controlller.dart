import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controller/location_controller.dart';
import 'package:getx_weather_app/helpers/weather_helper.dart';
import 'package:getx_weather_app/modals/favourite_modal.dart';
import 'package:getx_weather_app/modals/weather_modal.dart';

class WeatherController extends GetxController {
  Weather? weather;
  String city = "Surat";
  bool isFavorite = false;
  List<Favourite> allFavourite = [];
  // LocationController listenable = Get.put(LocationController());

  WeatherController() {
    loadData(city: city);
    initData();
  }
  Future<void> initData() async {
    WeatherHelper.wHelper.init();
    allFavourite = await WeatherHelper.wHelper.getAllData();
    update();
  }

  Future<void> insertData({required Favourite favorite}) async {
    WeatherHelper.wHelper.insertData(favorite: favorite);
    initData();
  }

  Future<void> deleteData({required String city}) async {
    WeatherHelper.wHelper.deleteData(city: city);
    initData();
  }

  Future<void> loadData({required String city}) async {
    weather = await WeatherHelper.wHelper.getWeatherData(cityName: city);
    update();
  }

  // Future<void> getLocation() async {
  //   Position position = await WeatherHelper.wHelper.determinePosition();
  //   listenable.loadData(lat: position.latitude, lon: position.longitude);
  //   await loadData(city: listenable.location!.name);
  // }
}

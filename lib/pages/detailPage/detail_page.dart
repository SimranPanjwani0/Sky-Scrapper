import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controller/weather_controlller.dart';
import 'package:getx_weather_app/modals/location_modal.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherController listenable = Get.find<WeatherController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: const Text(
          "Favourite",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: listenable.allFavourite.isEmpty
            ? const Center(
                child: Text("No Data"),
              )
            : Column(
                children: listenable.allFavourite
                    .map(
                      (e) => Text(
                        e.city,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

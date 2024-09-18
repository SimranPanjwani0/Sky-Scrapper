import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/pages/detailPage/detail_page.dart';
import 'package:getx_weather_app/pages/homePage/home_page.dart';
import 'package:getx_weather_app/pages/splashPage/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/favourite',
          page: () => const FavouritePage(),
        ),
      ],
    );
  }
}

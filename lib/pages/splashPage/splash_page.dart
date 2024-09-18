import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed('home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: s.height,
          width: s.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://thumbs.dreamstime.com/b/weather-forecast-concept-collage-variety-conditions-climate-change-background-sky-image-bright-sun-blue-dark-stormy-149924291.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

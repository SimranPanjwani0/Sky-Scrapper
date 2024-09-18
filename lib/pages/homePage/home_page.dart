import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controller/theme_controller.dart';
import 'package:getx_weather_app/controller/weather_controlller.dart';
import 'package:getx_weather_app/modals/favourite_modal.dart';
import 'package:getx_weather_app/modals/weather_modal.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String city = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    WeatherController listenable = Get.put(WeatherController());
    ThemeController themeController = Get.put(ThemeController());
    // listenable.getLocation();
    Size s = MediaQuery.sizeOf(context);
    return GetBuilder<ThemeController>(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<WeatherController>(builder: (context) {
          return GestureDetector(
            onDoubleTap: () {
              listenable.isFavorite = !listenable.isFavorite;
              listenable.insertData(
                favorite: Favourite(city, 0),
              );
              listenable.isFavorite = !listenable.isFavorite;
            },
            child: Stack(
              children: [
                GetBuilder<ThemeController>(builder: (context) {
                  return Container(
                    height: s.height,
                    width: s.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: themeController.isDark
                            ? const NetworkImage(
                                "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRynonPKugC4WaAGlVgkQu8yobY7ACPnO5cGXdWuiq2Bm_8ItAq")
                            : const NetworkImage(
                                "https://i.pinimg.com/736x/0d/ee/62/0dee620a0864944d2bdab69c6f279e8d.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
                Column(
                  children: [
                    SizedBox(
                      height: s.height * 0.04,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: s.width * 0.3,
                        ),
                        Text(
                          "All Weather",
                          style: TextStyle(
                            color: themeController.isDark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: s.width * 0.11,
                        ),
                        GetBuilder<ThemeController>(
                          builder: (context) => IconButton(
                            onPressed: () {
                              themeController.changeTheme();
                            },
                            icon: themeController.isDark
                                ? const Icon(
                                    Icons.dark_mode,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.light_mode_sharp,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                        IconButton(
                          icon: themeController.isDark
                              ? const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            Get.toNamed("/favourite");
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        controller: textController,
                        style: const TextStyle(color: Colors.white),
                        onFieldSubmitted: (val) {
                          city = val;
                          listenable.loadData(city: city);
                          textController.clear();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text(
                            "search",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: s.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // listenable.getLocation();
                          },
                          icon: Icon(
                            Icons.location_on_rounded,
                            color: themeController.isDark
                                ? Colors.white
                                : Colors.black,
                            size: 30,
                          ),
                        ),
                        Text(
                          " ${listenable.weather?.location.name}",
                          style: TextStyle(
                            color: themeController.isDark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: s.height * 0.03,
                    ),
                    Container(
                      height: s.height * 0.17,
                      width: s.width * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/weather3.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: s.height * 0.03,
                    ),
                    Text(
                      "${listenable.weather?.current.tempC}° C",
                      style: TextStyle(
                        color: themeController.isDark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: s.height * 0.03,
                    ),
                    Text(
                      " ${months[DateTime.now().month]} ${DateTime.now().day} ${days[DateTime.now().weekday]} ",
                      style: TextStyle(
                        color: themeController.isDark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: s.height * 0.04,
                    ),
                    GetBuilder<ThemeController>(builder: (context) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            height: s.height * 0.31,
                            width: s.width,
                            decoration: BoxDecoration(
                              color: themeController.isDark
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const CircleAvatar(
                                          radius: 35,
                                          foregroundImage: AssetImage(
                                              "assets/images/wind.png"),
                                        ),
                                        Text(
                                          "${listenable.weather?.current.windKph ?? "10"} Km/h",
                                          style: TextStyle(
                                            color: themeController.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const CircleAvatar(
                                          radius: 35,
                                          foregroundImage: AssetImage(
                                              "assets/images/humidity.png"),
                                        ),
                                        Text(
                                          "${listenable.weather?.current.humidity ?? "60"} %",
                                          style: TextStyle(
                                            color: themeController.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const CircleAvatar(
                                          radius: 35,
                                          foregroundImage: AssetImage(
                                              "assets/images/wind.png"),
                                        ),
                                        Text(
                                          "${listenable.weather?.current.cloud ?? "60"} %",
                                          style: TextStyle(
                                            color: themeController.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const CircleAvatar(
                                          radius: 35,
                                          foregroundImage: AssetImage(
                                              "assets/images/humidity.png"),
                                        ),
                                        Text(
                                          "${listenable.weather?.current.visKm ?? "15"} Km",
                                          style: TextStyle(
                                            color: themeController.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, -0.1),
                  child: Visibility(
                    visible: listenable.isFavorite,
                    child: const Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
                      size: 80,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}

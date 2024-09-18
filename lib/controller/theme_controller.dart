import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool isDark = false;

  void changeTheme() {
    isDark = !isDark;
    update();
    print('${isDark}');
  }
}

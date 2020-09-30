import 'package:get/get.dart';
import 'package:lists/utils/get_background.dart';

class Controller extends GetxController {
  var count = 0.obs;
  var background = 'assets/images/1.jpg'.obs;

  void changeBackground() {
    background.value = getBackground();
  }
  increment() => count.value++;
}

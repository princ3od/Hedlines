import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;

  void changeTab(int value) {
    this.index.value = value;
    update();
  }
}

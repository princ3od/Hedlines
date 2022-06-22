import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/constants/constants.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;
  late PageController pageController;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: 0,
    );
  }

  void changeTab(int value) {
    index.value = value;
    update();
    pageController.animateToPage(value, duration: ANIMATION_DURATION_500_MS, curve: Curves.linearToEaseOut);
  }
}

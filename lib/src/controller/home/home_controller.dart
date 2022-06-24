import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/constants/constants.dart';

class HomeController extends GetxController {
  RxInt tabIndex = 0.obs;
  late PageController pageController;
  late PageController articlePageController;
  var canNavigateToArticleDetail = true.obs;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: 0,
    );
    articlePageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  void changeTab(int value) {
    tabIndex.value = value;
    canNavigateToArticleDetail.value = tabIndex.value == 0;
    update();
    pageController.animateToPage(value,
        duration: ANIMATION_DURATION_500_MS, curve: Curves.linearToEaseOut);
  }

  void toArticleDetail() {
    if (canNavigateToArticleDetail.value) {
      articlePageController.animateToPage(1,
          duration: ANIMATION_DURATION_500_MS, curve: Curves.linearToEaseOut);
    }
  }

  void toHomeScreen() {
    if (canNavigateToArticleDetail.value) {
      articlePageController.animateToPage(0,
          duration: ANIMATION_DURATION_500_MS, curve: Curves.linearToEaseOut);
    }
  }
}

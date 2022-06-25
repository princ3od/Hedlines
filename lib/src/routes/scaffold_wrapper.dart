import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/constants/slide_mode.dart';
import 'package:hedlines/src/controller/home/home_controller.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_sign_out.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_wrapper.dart';
import '../configs/theme/app_colors.dart';
import '../constants/constants.dart';
import '../controller/home/home_tab/home_tab_controller.dart';
import 'app_pages.dart';

class ScaffoldWrapper extends StatefulWidget {
  final Widget child;

  const ScaffoldWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _ScaffoldWrapperState createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> {
  _hideKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        HomeTabController homeTabController = Get.find<HomeTabController>();
        HomeController homeController = Get.find<HomeController>();
        if (homeController.articlePageController.page == 1) {
          homeController.toHomeScreen();
          return false;
        }
        if (homeController.tabIndex > 0) {
          homeController.pageController.animateToPage(0,
              duration: ANIMATION_DURATION_500_MS,
              curve: Curves.linearToEaseOut);
          homeController.tabIndex.value = 0;
          return false;
        }
        if (homeTabController.currentIndex > 0) {
          homeTabController.pageController.animateToPage(0,
              duration: ANIMATION_DURATION_500_MS,
              curve: Curves.linearToEaseOut);
          homeTabController.currentIndex = 0;
          homeController.canNavigateToArticleDetail.value = true;
          return false;
        }
        if (!AppNavigator.canPop) {
          await dialogAnimationWrapper(
            slideFrom: SlideMode.bot,
            child: DialogSignOut(
              onConfirmed: () async {
                AppNavigator.pop();
                exit(0);
              },
              title: "Cảnh báo",
              bodyText: "Bạn có chắc chắn\n muốn thoát app?",
              bodyColor: backgroundPrimaryColor,
              hasTextShadow: true,
            ),
          );

          return false;
        }
        return true;
      },
      child: _child,
    );
  }

  Widget get _child {
    return _getBody;
  }

  Widget get _getBody {
    return GestureDetector(
      onTap: () => _hideKeyboard(),
      child: widget.child,
    );
  }
}

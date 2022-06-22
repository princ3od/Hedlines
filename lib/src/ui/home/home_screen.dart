// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/lang/localization.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/controller/home/home_controller.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/app_bars/app_bar_brighness_dark.dart';
import 'package:hedlines/src/ui/common/badges/badge.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/common/text_ui/text_ui.dart';
import 'package:hedlines/src/ui/home/screens/home_tab/home_tab.dart';
import 'package:hedlines/src/ui/home/screens/profile_tab/profile_tab.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/home/widgets/home_overlay.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

import 'screens/search_tab/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final homeController = Get.put(HomeController());
  // ignore: prefer_final_fields
  List<Widget> _tabs = [
    const HomeTab(),
    const SearchTab(),
    const ProfileTab(),
  ];

  late Animation<double> animation;
  late AnimationController controller;

  late final OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: ANIMATION_DURATION_1000_MS, vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut)
          ..addListener(() {});
    overlayEntry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(animation),
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.black.withOpacity(0.45),
            child: HomeOverlay(
              onTap: () {
                controller.reverse().then((value) {
                  overlayEntry.remove();
                });
              },
            ),
          ),
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
      _insertOverlay(context);
    });
  }

  void _insertOverlay(BuildContext context) {
    return Overlay.of(context)?.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final pageView = PageView(
      controller: homeController.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ..._tabs,
      ],
    );
    return Scaffold(
      appBar: appBarBrighnessDark(),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: backgroundPrimaryColor,
        elevation: .0,
        child: Container(
          height: 50.sp,
          padding: EdgeInsets.symmetric(horizontal: 6.5.sp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: .2,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildItemBottomBar(
                inActiveIcon: AssetsHelper.iconHome,
                activeIcon: AssetsHelper.iconHomeActive,
                index: 0,
                title: Strings.home.i18n,
              ),
              _buildItemBottomBar(
                inActiveIcon: AssetsHelper.iconSearch,
                activeIcon: AssetsHelper.iconSearchActive,
                index: 1,
                title: Strings.search.i18n,
              ),
              _buildItemBottomBar(
                inActiveIcon: AssetsHelper.iconProfile,
                activeIcon: AssetsHelper.iconProfileActive,
                index: 2,
                title: Strings.profile.i18n,
              ),
            ],
          ),
        ),
      ),
      body: pageView,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildItemBottomBar(
      {inActiveIcon, activeIcon, index, title, int quantity = 0}) {
    return Obx(
      () => Expanded(
        child: TouchableOpacity(
          onTap: () {
            homeController.changeTab(index);
          },
          child: Container(
            color: backgroundPrimaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Badge(
                  badgeContent: TextUI(
                    '$quantity',
                    color: colorGreen2,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  showBadge: quantity > 0,
                  badgeColor: colorGreen5,
                  child: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      homeController.index == index ? activeIcon : inActiveIcon,
                      width: 21.sp,
                      height: 21.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.5.sp),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: homeController.index == index
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color:
                        homeController.index == index ? colorWhite : colorWhite,
                    fontFamily: HEDLINES_FONT,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

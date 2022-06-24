import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/ui/home/screens/home_tab/widgets/home_context.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final homeTabController = Get.put(HomeTabController());

  @override
  initState() {
    super.initState();
    homeTabController.pageController = PageController(
      initialPage: homeTabController.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return GetBuilder<HomeTabController>(
      builder: (_) {
        return PageView.builder(
          itemCount: homeTabController.articles.length + 1,
          controller: homeTabController.pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: homeTabController.onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            if (homeTabController.articles.isNotEmpty &&
                index < homeTabController.articles.length) {
              return HomeContext(
                  sizeScreen: sizeScreen,
                  article: homeTabController.articles[index]);
            }
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: HomeContext(
                  sizeScreen: sizeScreen,
                  article: homeTabController.currentArticle),
            );
          },
        );
      },
    );
  }
}

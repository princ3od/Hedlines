import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/ui/home/screens/home_tab/widgets/home_context.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final homeTabController = Get.put(HomeTabController());

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return GetBuilder<HomeTabController>(
      builder: (_) {
        return PageView.builder(
          itemCount: 3,
          controller: homeTabController.pageController,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return HomeContext(sizeScreen: sizeScreen, articleDescription: homeTabController.listArticleDescription[index]);
          },
        );
      },
    );
  }
}

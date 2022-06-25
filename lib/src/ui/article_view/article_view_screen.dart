import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/model/article.dart';
import 'package:hedlines/src/ui/home/screens/home_tab/widgets/home_context.dart';

import '../../constants/constants.dart';
import '../article_detail/article_detail_screen.dart';

// ignore: must_be_immutable
class ArticleViewScreen extends StatelessWidget {
  ArticleViewScreen({Key? key, required this.article}) : super(key: key);
  final Article article;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
        body: PageView(
      controller: pageController,
      children: [
        Stack(
          children: [
            HomeContext(
                sizeScreen: sizeScreen,
                article: article,
                onToDetail: () {
                  pageController.animateToPage(1,
                      duration: ANIMATION_DURATION_500_MS, curve: Curves.ease);
                }),
            Padding(
              padding: const EdgeInsets.only(top: 48, left: 16),
              child: IconButton(
                onPressed: (() => Get.back()),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        ArticleDetailScreen(
          article: article,
          onBack: () {
            pageController.animateToPage(0,
                duration: ANIMATION_DURATION_500_MS, curve: Curves.ease);
          },
        ),
      ],
    ));
  }
}

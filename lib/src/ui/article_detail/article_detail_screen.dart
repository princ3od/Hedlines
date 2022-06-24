import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/article_detail/widgets/app_bar.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:async';

import '../../configs/theme/app_colors.dart';
import '../../controller/home/home_controller.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    HomeTabController homeTabController = Get.find<HomeTabController>();
    var article = homeTabController.currentArticle;
    return Scaffold(
      appBar: appBarTitleBack(
        title: article?.title ?? "Hedlines",
        onBackPressed: () {
          HomeController homeController = Get.find<HomeController>();
          homeController.toHomeScreen();
        },
        actions: [
          LikeButton(
            size: 32,
            circleColor: const CircleColor(
              start: Colors.white,
              end: Colors.white,
            ),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Colors.white,
              dotSecondaryColor: Colors.white,
            ),
            onTap: (tapped) async {
              Share.share('${article!.title} - ${article.url}');
              return true;
            },
            isLiked: article?.isLiked ?? false,
            likeBuilder: (bool isLiked) {
              return Icon(
                isLiked ? Icons.share_rounded : Icons.share_outlined,
                color: Colors.white,
                size: 28,
              );
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: article?.url ?? "https://www.se.uit.edu.vn",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {},
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.prevent;
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

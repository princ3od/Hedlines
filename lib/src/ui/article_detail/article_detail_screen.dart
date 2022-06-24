import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/ui/article_detail/widgets/app_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:async';

import '../../controller/home/home_controller.dart';
import '../../model/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key, this.article, this.onBack})
      : super(key: key);
  final Article? article;
  final Function? onBack;
  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  HomeTabController homeTabController = Get.find<HomeTabController>();
  final Set<Factory<EagerGestureRecognizer>> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();
  @override
  Widget build(BuildContext context) {
    var article = widget.article ?? homeTabController.currentArticle;
    return Scaffold(
      appBar: appBarTitleBack(
        title: article?.title ?? "Hedlines",
        onBackPressed: widget.onBack ??
            () {
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
        gestureRecognizers: gestureRecognizers,
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/constants/args_key.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/article_detail/widgets/app_bar.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:async';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBarTitleBack(
        title: args?[AppArgsKey.title] ?? "Hedlines",
        actions: [
          TouchableOpacity(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: SvgPicture.asset(
                AssetsHelper.iconShare,
                width: 23.sp,
                height: 23.sp,
                color: colorWhite,
              ),
            ),
          ),
        ],
      ),
      body: WebView(
        initialUrl: args?[AppArgsKey.initialUrl] ?? 'https://tuoitre.vn/the-gioi.htm',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {},
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
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

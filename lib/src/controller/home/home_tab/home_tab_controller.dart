import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/constants/slide_mode.dart';
import 'package:hedlines/src/data/hard_data/mock_data.dart';
import 'package:hedlines/src/model/fake_model/article_description.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_announcement.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_wrapper.dart';

class HomeTabController extends GetxController {
  List<Article> backupListArticleDescription = [];
  RxList<Article> listArticleDescription = RxList<Article>();
  bool isLoading = false;
  bool isEnd = false;
  late PageController pageController;

  get colorGray1 => null;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: 0,
    );
    for (int i = 0; i < 10; i++) {
      backupListArticleDescription.add(MockData.articles[MockData.articles.length - i - 1]);
    }
    listArticleDescription.value = backupListArticleDescription.sublist(backupListArticleDescription.length - 10, backupListArticleDescription.length);
    update();
  }

  indexChange(int index) {}

  //asset listArticleDescription <=10;
  // ignore: unused_element
  _addArticleDescription() {
    if (listArticleDescription.length <= 10) {
      var articleRemove = listArticleDescription.first;
      listArticleDescription.remove(articleRemove);
      int indexOfRemove = backupListArticleDescription.indexOf(articleRemove);
      if (indexOfRemove == 0) {
        showDialogAnnouncement();
        return;
      }
      if (indexOfRemove < 5) {
        _loadMoreArticleDescription(backupListArticleDescription.length);
      }
      listArticleDescription.add(backupListArticleDescription[indexOfRemove - 1]);
    }
  }

  _loadMoreArticleDescription(int skip) async {
    isLoading = true;
    //mock load more article
    await Future.delayed(ANIMATION_DURATION_2000_MS).then((value) {
      int begin = skip < MockData.articles.length - 1 ? skip : -1;
      int end = skip + 10 <= MockData.articles.length - 1 ? skip + 10 : MockData.articles.length - 1;
      if (begin != -1 && end > begin && !isEnd) {
        backupListArticleDescription = [...MockData.articles.sublist(begin, end), ...backupListArticleDescription];
      } else {
        isEnd = true;
      }
    });
    isLoading = false;
    update();
  }

  //show announcement user readied all article
  showDialogAnnouncement() async {
    await dialogAnimationWrapper(
      slideFrom: SlideMode.bot,
      child: DialogAnnouncement(
        title: "Thông báo",
        bodyBefore: "Bạn đã đọc hết tổng cộng",
        bodyAfter: "bài viết, hãy tiếp tục các bài viết trong khi chúng tôi chuẩn bị nội dung cho bạn.",
        highlightColor: Colors.red,
        highlightText: "10",
        bodyColor: colorBlack,
        confirmText: "Xác nhận",
        beforeTextAlign: TextAlign.justify,
        onConfirmed: () {
          AppNavigator.pop();
        },
      ),
    );
  }

  //
  void handleTransactionPage(dynamic args) {
    _handleTransactionPage(args);
  }

  void _handleTransactionPage(dynamic args) {
    AppNavigator.push(Routes.ARTICLE_DETAIL, arguments: args);
  }
}

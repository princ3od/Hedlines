import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/lang/localization.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/slide_mode.dart';
import 'package:hedlines/src/data/hard_data/mock_data.dart';
import 'package:hedlines/src/model/fake_model/article_description.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_announcement.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_confirm_cancel.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_wrapper.dart';

class HomeTabController extends GetxController {
  List<ArticleDescription> backupListArticleDescription = [];
  RxList<ArticleDescription> listArticleDescription = RxList<ArticleDescription>();
  bool isLoading = false;
  late PageController pageController;

  get colorGray1 => null;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        if (pageController.page!.round() >= 1) {}
      });
    // get first 10 article
    for (int i = 0; i < 10; i++) {
      backupListArticleDescription.add(MockData.articles[MockData.articles.length - i - 1]);
    }
    listArticleDescription.value = backupListArticleDescription.sublist(backupListArticleDescription.length - 10, backupListArticleDescription.length);
    update();
  }

  //asset listArticleDescription <=10;
  _addArticleDescription() {
    if (listArticleDescription.length <= 10) {
      var articleRemove = listArticleDescription.first;
      listArticleDescription.remove(articleRemove);
      int indexOfRemove = backupListArticleDescription.indexOf(articleRemove);
      if (indexOfRemove == 0) {}
      listArticleDescription.add(backupListArticleDescription[indexOfRemove - 1]);
    }
  }

  //show announcement user readied all article
  static showDialogAnnouncement() async {
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
}

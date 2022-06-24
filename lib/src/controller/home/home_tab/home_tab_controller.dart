import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/data/remote_data_source/article_recommender_repository.dart';
import 'package:hedlines/src/services/storage_service/user_storage.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/local_storage.dart';
import '../../../model/article.dart';

class HomeTabController extends GetxController {
  var articles = <Article>[];
  var currentIndex = 0;
  var isLoading = false.obs;
  late PageController pageController;

  Article? get currentArticle =>
      (articles.isNotEmpty) ? articles[currentIndex] : null;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    pageController = PageController(
      initialPage: 0,
    );
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    articles = await ArticleRecommenderRepository()
            .fetchArticles(FirebaseAuth.instance.currentUser!.uid) ??
        [];
    update();
    isLoading.value = false;
  }

  onPageChanged(int index) async {
    if (LocalStorage.isFirstOpen()) {
      LocalStorage.setFirstOpen(false);
    }
    if (index < articles.length) {
      currentIndex = index;
    } else {
      await loadMoreArticles();
    }
    await UserInfoService().setPreviousViewedArticle(currentArticle);
  }

  loadMoreArticles() async {
    isLoading.value = true;
    articles.addAll(
      await ArticleRecommenderRepository()
              .fetchArticles(FirebaseAuth.instance.currentUser!.uid) ??
          [],
    );
    update();
    isLoading.value = false;
  }

  likeArticle(bool isLiked, {Article? article}) async {
    if (isLiked) {
      await UserInfoService().unlikeArticle(article ?? currentArticle!);
    } else {
      await UserInfoService().likeArticle(article ?? currentArticle!);
    }
    if (article != null) {
      Article? articleInCurrentSection =
          articles.firstWhereOrNull((e) => e.id == article.id);
      articleInCurrentSection?.isLiked = !isLiked;
      articleInCurrentSection?.numberOfFavorite += (isLiked ? -1 : 1);
    } else {
      articles[currentIndex].isLiked = !isLiked;
      articles[currentIndex].numberOfFavorite += isLiked ? -1 : 1;
    }
  }
}

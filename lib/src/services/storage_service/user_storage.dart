import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedlines/src/model/article.dart';

import '../../controller/app_controller.dart';
import '../../model/social_model.dart';
import '../../model/user_model.dart';

class UserInfoService {
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel userModel) async {
    await usersRef.doc(userModel.id).set(userModel.toMap());
  }

  Future<UserModel?> getUserInfo(SocialModel socialModel) async {
    return await usersRef
        .doc(socialModel.googleId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.data() == null) {
        return null;
      }

      final data = doc.data() as Map<String, dynamic>;
      var userModel = UserModel.fromMap(data);
      userModel.id = socialModel.googleId;
      return userModel;
    });
  }

  Future<UserModel?> getUser(String id) async {
    return await usersRef.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.data() == null) {
        return null;
      }

      final data = doc.data() as Map<String, dynamic>;
      var userModel = UserModel.fromMap(data);
      userModel.id = id;
      return userModel;
    });
  }

  Future<void> setUserTopics(List<String> topics) async {
    await usersRef.doc(AppController.userInfo.value?.id).update({
      'preferences': topics,
    });
  }

  Future<void> setPreviousViewedArticle(Article? article) async {
    if (article == null) {
      return;
    }
    await usersRef.doc(AppController.userInfo.value?.id).set({
      'previous_viewed_articles': {
        article.topic["id"]: article.id,
      }
    }, SetOptions(merge: true));
  }

  Future<void> likeArticle(Article article) async {
    await usersRef.doc(AppController.userInfo.value?.id).set({
      'liked_articles': {
        article.id: article.date,
      }
    }, SetOptions(merge: true));
    var articleRef =
        FirebaseFirestore.instance.collection('articles').doc(article.id);
    await articleRef.set({
      'liked_by': {
        AppController.userInfo.value?.id: DateTime.now(),
      }
    }, SetOptions(merge: true));
  }

  Future<void> unlikeArticle(Article article) async {
    await usersRef.doc(AppController.userInfo.value?.id).set({
      'liked_articles': {
        article.id: FieldValue.delete(),
      }
    }, SetOptions(merge: true));
    var articleRef =
        FirebaseFirestore.instance.collection('articles').doc(article.id);
    await articleRef.set({
      'liked_by': {
        AppController.userInfo.value?.id: FieldValue.delete(),
      }
    }, SetOptions(merge: true));
  }

  static final UserInfoService _authService = UserInfoService._internal();

  UserInfoService._internal();
  factory UserInfoService() {
    return _authService;
  }
}

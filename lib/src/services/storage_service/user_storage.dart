import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedlines/src/model/fake_model/social_model.dart';

import '../../controller/app_controller.dart';
import '../../model/fake_model/account_model.dart';

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

  Future<void> setUserTopics(Set<String> topics) async {
    await usersRef.doc(AppController.userInfo.value?.id).update({
      'preferences': topics.toList(),
    });
  }

  static final UserInfoService _authService = UserInfoService._internal();

  UserInfoService._internal();
  factory UserInfoService() {
    return _authService;
  }
}

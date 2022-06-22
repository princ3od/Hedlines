import 'package:cloud_firestore/cloud_firestore.dart';

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

  static final UserInfoService _authService = UserInfoService._internal();

  UserInfoService._internal();
  factory UserInfoService() {
    return _authService;
  }
}

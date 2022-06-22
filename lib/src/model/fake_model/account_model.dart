import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedlines/src/model/fake_model/social_model.dart';

import '../../helper/utils/date_time_helper.dart';
import '../../helper/utils/string_helper.dart';

class UserModel {
  String? id;
  final String? username;
  String? fullname;
  String? email;
  final String? avatar;
  //
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final DateTime? lastVisted;
  final Map<String, DateTime>? liked;
  final Map<String, String>? previousViewedArticle;

  List<dynamic> preferences = [];
  UserModel({
    this.lastVisted,
    this.liked,
    this.previousViewedArticle,
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.avatar,
    this.createdAt,
    this.modifiedAt,
    required this.preferences,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? fullname,
    String? email,
    String? avatar,
    //
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      preferences: [...preferences],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'avatar': avatar,
      'preferences': preferences,
      'last_visited': lastVisted,
      'liked': liked,
      'previous_viewed_article': previousViewedArticle,
    };
  }

  factory UserModel.fromSocial(SocialModel socialModel) {
    return UserModel(
      id: socialModel.googleId,
      username: socialModel.fullName,
      fullname: socialModel.fullName,
      email: socialModel.email ?? "hedlines@gmail.com",
      avatar: socialModel.googleAvatar,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      lastVisted: DateTime.now(),
      preferences: [],
      liked: {},
      previousViewedArticle: {},
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      modifiedAt: (map['modifiedAt'] as Timestamp).toDate(),
      avatar: map['avatar'],
      preferences: map['preferences'] ?? [],
      lastVisted: (map['last_visited'] as Timestamp).toDate(),
      liked: DateTimeHelper.convertTimeStampToDateTime(map['liked']),
      previousViewedArticle:
          StringHeler.convertMapStringToString(map['previous_viewed_article']),
    );
  }

  factory UserModel.fromJson(String str) {
    var data = json.decode(str);
    return UserModel(
      id: data['id'],
      username: data['username'],
      fullname: data['fullname'],
      email: data['email'],
      createdAt:
          data['createdAt'] != null ? DateTime.parse(data['createdAt']) : null,
      modifiedAt: data['modifiedAt'] != null
          ? DateTime.parse(data['modifiedAt'])
          : null,
      avatar: data['avatar'],
      preferences: data['preferences'],
      lastVisted: data['last_visited'] != null
          ? DateTime.parse(data['lastVisted'])
          : null,
      liked: data['liked'] != null
          ? DateTimeHelper.convertTimeStampToDateTime(data['liked'])
          : null,
      previousViewedArticle: data['previous_viewed_article'] != null
          ? StringHeler.convertMapStringToString(
              data['previous_viewed_article'])
          : null,
    );
  }

  factory UserModel.fromUpdateUser(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'],
      modifiedAt: map['modifiedAt'],
      avatar: map['avatar'],
      preferences: map['preferences'],
      lastVisted: map['last_visited'],
      liked: map['liked'],
      previousViewedArticle: map['previous_viewed_article'],
    );
  }

  String toJson() => json.encode(
        toMap(),
        toEncodable: DateTimeHelper.myDateSerializer,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.username == username &&
        other.fullname == fullname &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode;
  }
}

import 'dart:convert';

class AccountModel {
  final String? id;
  final String? username;
  String? fullname;
  String? email;
  final int? gender;
  final String? createdAt;
  final String? modifiedAt;
  final String? avatar;
  AccountModel({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.gender,
    this.createdAt,
    this.modifiedAt,
    this.avatar,
  });

  AccountModel copyWith({
    String? id,
    String? username,
    String? fullname,
    String? email,
    int? gender,
    String? avatar,
    String? createdAt,
    String? modifiedAt,
  }) {
    return AccountModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'gender': gender,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'avatar': avatar,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['_id'],
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? 2,
      createdAt: map['createdAt'],
      modifiedAt: map['modifiedAt'],
      avatar: map['avatar'],
    );
  }

  factory AccountModel.fromUpdateUser(Map<String, dynamic> map) {
    return AccountModel(
      id: map['_id'],
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? 2,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) => AccountModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountModel && other.id == id && other.username == username && other.fullname == fullname && other.email == email && other.gender == gender && other.createdAt == createdAt && other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ username.hashCode ^ fullname.hashCode ^ email.hashCode ^ gender.hashCode ^ avatar.hashCode ^ createdAt.hashCode ^ modifiedAt.hashCode;
  }
}

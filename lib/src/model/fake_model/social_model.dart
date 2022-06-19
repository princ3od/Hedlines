import 'dart:convert';

class SocialModel {
  final String fullName;
  final String googleId;
  final String? googleAvatar;
  SocialModel({
    required this.fullName,
    required this.googleId,
    this.googleAvatar,
  });

  SocialModel copyWith({
    String? fullName,
    String? email,
    String? googleId,
  }) {
    return SocialModel(
      fullName: fullName ?? this.fullName,
      googleId: googleId ?? this.googleId,
      googleAvatar: googleAvatar ?? this.googleAvatar,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, String> result = {
      'fullname': fullName,
      'googleId': googleId,
      'googleAvatar': googleAvatar ?? "",
    };

    if (googleId != null) {
      result['googleID'] = googleId;
    }

    return result;
  }

  factory SocialModel.fromMap(Map<String, dynamic> map) {
    return SocialModel(
      fullName: map['fullName'] ?? '',
      googleId: map['googleId'],
      googleAvatar: map['googleAvatar'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialModel.fromJson(String source) => SocialModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SocialModel(fullName: $fullName,  googleId: $googleId), googleAvatar: $googleAvatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialModel && other.fullName == fullName && other.googleId == googleId;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^ googleId.hashCode;
  }
}

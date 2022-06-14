// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class AccountRemember {
  AccountRemember({
    this.account,
  });

  final List<Account>? account;

  factory AccountRemember.fromJson(String str) => AccountRemember.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountRemember.fromMap(Map<String, dynamic> json) => AccountRemember(
        account: json["account"] == null ? null : List<Account>.from(json["account"].map((x) => Account.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "account": account == null ? null : List<dynamic>.from(account!.map((x) => x.toMap())),
      };
}

class Account {
  Account({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        email: json["email"] == null ? null : json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}

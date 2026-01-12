import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.email, super.name});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
    );
  }
  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'name': name};
  }

  String toJson() {
    return json.encode(toMap());
  }
}

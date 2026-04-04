import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/login_entity.dart';

part 'login_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.decode)
class LoginResponseModel extends LoginResponseEntity
    with LoginResponseModelMappable {
  LoginResponseModel({
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.image,
    required super.accessToken,
    required super.gender,
    required this.refreshToken,
  });

  final String refreshToken;
}

class LoginRequestModel extends LoginRequestEntity {
  LoginRequestModel({required super.username, required super.password});

  factory LoginRequestModel.fromEntity(LoginRequestEntity entity) {
    return LoginRequestModel(
      username: entity.username,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

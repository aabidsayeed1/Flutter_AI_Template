import '../../../../core/user/user_entity.dart';

interface class LoginEntity {}

class LoginRequestEntity extends LoginEntity {
  LoginRequestEntity({
    required this.username,
    required this.password,
    this.shouldRemeber = false,
  });

  final String username;
  final String password;
  final bool? shouldRemeber;
}

class LoginResponseEntity extends LoginEntity {
  LoginResponseEntity({
    required this.accessToken,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  final String accessToken;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  User toUser() => User(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    gender: gender,
    image: image,
  );
}

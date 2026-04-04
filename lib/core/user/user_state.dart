part of 'user_cubit.dart';

enum UserStatus { initial, loaded, guest }

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(UserStatus.initial) UserStatus status,
    @Default(null) User? user,
  }) = _UserState;
}

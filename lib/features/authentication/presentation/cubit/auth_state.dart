part of 'auth_cubit.dart';

enum AuthStatus { unknown, loading, authenticated, unauthenticated, error }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    @Default(null) String? error,
  }) = _AuthState;
}

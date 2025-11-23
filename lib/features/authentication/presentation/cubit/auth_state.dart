part of 'auth_cubit.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isUnknown;
  final String? error;

  const AuthState._(this.isLoggedIn, this.isUnknown, this.error);

  const AuthState.unknown() : this._(false, true, null);
  const AuthState.authenticated() : this._(true, false, null);
  const AuthState.unauthenticated() : this._(false, false, null);
  const AuthState.error(String error) : this._(false, false, error);
}

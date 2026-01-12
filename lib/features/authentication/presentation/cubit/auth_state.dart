part of 'auth_cubit.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isUnknown;
  final String? error;
  final User? user;

  const AuthState._(this.isLoggedIn, this.isUnknown, this.error, {this.user});

  const AuthState.unknown() : this._(false, true, null);
  const AuthState.authenticated({User? user})
    : this._(true, false, null, user: user);
  const AuthState.unauthenticated() : this._(false, false, null);
  const AuthState.error(String error) : this._(false, false, error);
}

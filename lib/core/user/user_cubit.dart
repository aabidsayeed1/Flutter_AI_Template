import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../services/cache/cache_service.dart';
import 'user_entity.dart';
import 'user_model.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  final CacheService _cacheService;
  static const _keyUser = CacheKey.user;

  UserCubit(this._cacheService) : super(const UserState());

  /// Set user after login/signup and persist to cache.
  void setUser(User user) {
    final model = UserModel.fromUser(user);
    _cacheService.save(_keyUser, model.toJson());
    emit(state.copyWith(status: UserStatus.loaded, user: user));
  }

  /// Update user fields and persist.
  void updateUser(User Function(User current) update) {
    final current = user;
    if (current == null) return;
    final updated = update(current);
    setUser(updated);
  }

  /// Load user from cache (call on app start).
  Future<void> loadFromCache() async {
    final json = await _cacheService.getSecure(_keyUser);
    if (json != null && json.isNotEmpty) {
      emit(
        state.copyWith(
          status: UserStatus.loaded,
          user: UserModel.fromJson(json),
        ),
      );
    } else {
      emit(state.copyWith(status: UserStatus.guest, user: null));
    }
  }

  /// Clear user on logout.
  void clearUser() {
    _cacheService.remove([_keyUser]);
    emit(state.copyWith(status: UserStatus.guest, user: null));
  }

  /// Convenience getter for current user.
  User? get user => state.user;
}

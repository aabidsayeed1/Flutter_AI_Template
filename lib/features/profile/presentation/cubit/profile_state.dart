part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    @Default(null) ProfileEntity? profile,
    @Default(null) String? error,
  }) = _ProfileState;
}

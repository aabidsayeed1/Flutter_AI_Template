part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial) HomeStatus status,
    @Default(<HomeEntity>[]) List<HomeEntity> items,
    @Default(null) String? errorMessage,
  }) = _HomeState;
}

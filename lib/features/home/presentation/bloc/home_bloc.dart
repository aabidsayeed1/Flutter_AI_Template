import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/home_entity.dart';
import '../../domain/use_cases/get_home_items_usecase.dart';
part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeItemsUseCase getHomeItemsUseCase;

  HomeBloc(this.getHomeItemsUseCase) : super(const HomeState()) {
    // on<_LoadHome>(_onLoadHome);
  }

  // Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
  //   emit(state.copyWith(isLoading: true, errorMessage: null));
  //   try {
  //     final items = await getHomeItemsUseCase();
  //     emit(state.copyWith(isLoading: false, items: items));
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
  //   }
  // }
}

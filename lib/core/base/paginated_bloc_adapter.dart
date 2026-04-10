import 'package:flutter_template_2025/core/base/paginated_cubit.dart';
import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/logger/log.dart';

/// Adapter helper to bridge a `Bloc` that exposes `PaginatedState<T>` to
/// imperative methods used by UI widgets (loadInitial/loadMore/refresh/retry).
///
/// The adapter requires callers to provide small dispatcher callbacks that
/// `add(...)` the appropriate events for the target `Bloc`. This keeps the
/// adapter generic and library-agnostic while reducing boilerplate at call
/// sites.
class PaginatedBlocAdapter<T> {
  final BlocBase<PaginatedState<T>> bloc;
  final void Function() _addLoadInitial;
  final void Function() _addLoadMore;
  final void Function() _addRefresh;
  final void Function()? _addRetry;

  PaginatedBlocAdapter({
    required this.bloc,
    required void Function() addLoadInitial,
    required void Function() addLoadMore,
    required void Function() addRefresh,
    void Function()? addRetry,
  }) : _addLoadInitial = addLoadInitial,
       _addLoadMore = addLoadMore,
       _addRefresh = addRefresh,
       _addRetry = addRetry;

  /// Dispatches the provided load-initial event and waits until the
  /// bloc's `status` changes from the previous value.
  Future<void> loadInitial() {
    Log.debug(
      'PaginatedBlocAdapter.loadInitial() called (page=${bloc.state.page})',
    );
    final prevStatus = bloc.state.status;
    _addLoadInitial();
    return bloc.stream
        .firstWhere((s) => s.status != prevStatus)
        .then((_) => null);
  }

  /// Dispatches the provided load-more event and waits until the bloc's
  /// `page` advances or a load-more error is set on the state.
  Future<void> loadMore() {
    Log.debug(
      'PaginatedBlocAdapter.loadMore() called (page=${bloc.state.page})',
    );
    final prevPage = bloc.state.page;
    _addLoadMore();
    return bloc.stream
        .firstWhere((s) => s.page != prevPage || s.lastLoadMoreError == true)
        .then((_) => null);
  }

  /// Dispatches the provided refresh event and waits until `isRefreshing`
  /// becomes false again.
  Future<void> refresh() {
    Log.debug(
      'PaginatedBlocAdapter.refresh() called (page=${bloc.state.page})',
    );
    _addRefresh();
    return bloc.stream
        .firstWhere((s) => s.isRefreshing == false)
        .then((_) => null);
  }

  /// Fire-and-forget retry helper.
  void retry() {
    Log.debug('PaginatedBlocAdapter.retry() called');
    _addRetry?.call();
  }

  /// Convenience factory to create an adapter around a [PaginatedCubit]. This
  /// is useful when you want to reuse the same API surface for both Blocs and
  /// Cubits.
  factory PaginatedBlocAdapter.fromCubit(PaginatedCubit<T> cubit) {
    return PaginatedBlocAdapter<T>(
      bloc: cubit,
      addLoadInitial: () => cubit.loadInitial(),
      addLoadMore: () => cubit.loadMore(),
      addRefresh: () => cubit.refresh(),
      addRetry: () => cubit.retry(),
    );
  }
}

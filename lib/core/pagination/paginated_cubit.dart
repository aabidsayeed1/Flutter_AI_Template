import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/logger/log.dart';

/// Result returned by paginated data sources.
class PaginatedResult<T> {
  final List<T> items;
  final bool hasMore;

  PaginatedResult({required this.items, required this.hasMore});
}

enum PaginatedStatus { initial, loading, success, error }

class PaginatedState<T> {
  final PaginatedStatus status;
  final List<T> items;
  final bool isLoadingMore;
  final bool isRefreshing;
  final bool hasMore;
  final String? error;
  final int page;
  final bool lastLoadMoreError;
  final String? lastLoadMoreErrorMessage;

  const PaginatedState({
    this.status = PaginatedStatus.initial,
    this.items = const [],
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.hasMore = true,
    this.error,
    this.page = 0,
    this.lastLoadMoreError = false,
    this.lastLoadMoreErrorMessage,
  });

  PaginatedState<T> copyWith({
    PaginatedStatus? status,
    List<T>? items,
    bool? isLoadingMore,
    bool? isRefreshing,
    bool? hasMore,
    String? error,
    int? page,
    bool? lastLoadMoreError,
    String? lastLoadMoreErrorMessage,
  }) {
    return PaginatedState<T>(
      status: status ?? this.status,
      items: items ?? this.items,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
      page: page ?? this.page,
      lastLoadMoreError: lastLoadMoreError ?? this.lastLoadMoreError,
      lastLoadMoreErrorMessage:
          lastLoadMoreErrorMessage ?? this.lastLoadMoreErrorMessage,
    );
  }

  static PaginatedState<T> initial<T>() => PaginatedState<T>();
}

/// Base Cubit for paginated lists.
///
/// Subclasses must implement [fetchPage]. The cubit exposes simple methods:
/// `loadInitial()`, `loadMore()`, `refresh()`, and `retry()`.
abstract class PaginatedCubit<T> extends Cubit<PaginatedState<T>> {
  final int pageSize;

  PaginatedCubit({this.pageSize = 20}) : super(PaginatedState.initial<T>());

  bool _isFetching = false;

  /// Fetch a page from the data source. Return items + whether more pages exist.
  Future<PaginatedResult<T>> fetchPage(int page, int pageSize);

  Future<void> loadInitial() async {
    if (_isFetching) return;
    _isFetching = true;
    emit(
      state.copyWith(
        status: PaginatedStatus.loading,
        error: null,
        page: 0,
        items: [],
        lastLoadMoreError: false,
      ),
    );
    try {
      final result = await fetchPage(1, pageSize);
      emit(
        state.copyWith(
          status: PaginatedStatus.success,
          items: result.items,
          hasMore: result.hasMore,
          page: 1,
          isLoadingMore: false,
          isRefreshing: false,
          lastLoadMoreError: false,
        ),
      );
    } catch (e, st) {
      Log.error('PaginatedCubit.loadInitial failed: $e');
      if (kDebugMode) Log.error(st.toString());
      emit(
        state.copyWith(
          status: PaginatedStatus.error,
          error: e.toString(),
          isLoadingMore: false,
          isRefreshing: false,
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    if (!state.hasMore) return;
    _isFetching = true;
    emit(
      state.copyWith(
        isLoadingMore: true,
        error: null,
        lastLoadMoreError: false,
        lastLoadMoreErrorMessage: null,
      ),
    );
    final nextPage = state.page + 1;
    try {
      final result = await fetchPage(nextPage, pageSize);
      final newItems = List<T>.from(state.items)..addAll(result.items);
      emit(
        state.copyWith(
          status: PaginatedStatus.success,
          items: newItems,
          hasMore: result.hasMore,
          page: nextPage,
          isLoadingMore: false,
          lastLoadMoreError: false,
        ),
      );
    } catch (e, st) {
      Log.error('PaginatedCubit.loadMore failed: $e');
      if (kDebugMode) Log.error(st.toString());
      emit(
        state.copyWith(
          isLoadingMore: false,
          status: PaginatedStatus.success,
          lastLoadMoreError: true,
          lastLoadMoreErrorMessage: e.toString(),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    // If no items yet, use loadInitial (shows full-page loader)
    if (state.items.isEmpty) return loadInitial();
    if (_isFetching) return;
    _isFetching = true;
    emit(
      state.copyWith(isRefreshing: true, error: null, lastLoadMoreError: false),
    );
    try {
      final result = await fetchPage(1, pageSize);
      // Prepend only new items that are not currently in the list
      final existing = state.items;
      final newOnly = result.items.where((e) => !existing.contains(e)).toList();
      if (newOnly.isNotEmpty) {
        final updated = List<T>.from(newOnly)..addAll(existing);
        emit(
          state.copyWith(
            items: updated,
            hasMore: result.hasMore,
            isRefreshing: false,
            status: PaginatedStatus.success,
          ),
        );
      } else {
        emit(state.copyWith(isRefreshing: false));
      }
    } catch (e, st) {
      Log.error('PaginatedCubit.refresh failed: $e');
      if (kDebugMode) Log.error(st.toString());
      emit(state.copyWith(isRefreshing: false, error: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  void retry() {
    // If last load-more failed, retry loadMore
    if (state.lastLoadMoreError) {
      loadMore();
      return;
    }

    if (state.status == PaginatedStatus.error) {
      loadInitial();
    }
  }
}

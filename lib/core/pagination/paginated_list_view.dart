import 'package:flutter_template_2025/core/pagination/paginated_cubit.dart';
import 'package:flutter_template_2025/core/pagination/paginated_controller.dart';
import 'package:flutter_template_2025/core/logger/log.dart';

import 'package:flutter_template_2025/core/base/export.dart';

/// A generic paginated list view that works with [PaginatedCubit].
class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.enablePullToRefresh = true,
    this.loadMoreThreshold = 200.0,
    this.onLoadInitial,
    this.onLoadMore,
    this.onRefresh,
    this.controller,
    this.onRetry,
  });

  /// Any `Bloc` or `Cubit` exposing `PaginatedState<T>` as its state.
  final BlocBase<PaginatedState<T>> bloc;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsets? padding;
  final bool enablePullToRefresh;
  final double loadMoreThreshold;

  /// Optional controller that exposes imperative methods for Bloc-backed
  /// paginated flows. If provided, the controller will be preferred over
  /// individual callbacks (`onLoadInitial`, `onLoadMore`, etc.).
  final PaginatedController<T>? controller;

  // Optional callbacks for non-Cubit implementations (e.g. Bloc).
  final Future<void> Function()? onLoadInitial;
  final Future<void> Function()? onLoadMore;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onRetry;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    // Load initial data when the widget appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final status = widget.bloc.state.status;
      if (status == PaginatedStatus.initial) {
        if (widget.controller != null) {
          widget.controller!.loadInitial();
        } else if (widget.onLoadInitial != null) {
          widget.onLoadInitial!();
        } else if (widget.bloc is PaginatedCubit<T>) {
          (widget.bloc as PaginatedCubit<T>).loadInitial();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final threshold = widget.loadMoreThreshold;
    final max = _controller.position.maxScrollExtent;
    final pixels = _controller.position.pixels;
    if (max - pixels <= threshold) {
      if (widget.controller != null) {
        widget.controller!.loadMore();
      } else if (widget.onLoadMore != null) {
        widget.onLoadMore!();
      } else if (widget.bloc is PaginatedCubit<T>) {
        (widget.bloc as PaginatedCubit<T>).loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBase<PaginatedState<T>>, PaginatedState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        Log.debug(
          'PaginatedListView state: page=${state.page}, items=${state.items.length}, isLoadingMore=${state.isLoadingMore}, lastLoadMoreError=${state.lastLoadMoreError}, lastLoadMoreErrorMessage=${state.lastLoadMoreErrorMessage}, hasMore=${state.hasMore}, status=${state.status}',
        );
        // Full-page loading: show attractive skeleton placeholders
        if (state.status == PaginatedStatus.loading && state.items.isEmpty) {
          return const _SkeletonList();
        }

        // Full-page error (no items): show card with icon + retry
        if (state.status == PaginatedStatus.error && state.items.isEmpty) {
          final msg = state.error;
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: context.color.error,
                      ),
                      Gap(12.r),
                      Text(
                        msg ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: context.textStyle.bodyLarge,
                      ),
                      Gap(16.r),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (widget.controller != null) {
                            widget.controller!.retry();
                          } else if (widget.onRetry != null) {
                            widget.onRetry!.call();
                          } else if (widget.bloc is PaginatedCubit<T>) {
                            (widget.bloc as PaginatedCubit<T>).retry();
                          }
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        final itemCount = state.items.length + 1; // footer

        // Ensure footer is reachable above system bottom insets (home indicator,
        // bottom navigation bars, etc.) by adding safe-area bottom padding.
        final basePadding = widget.padding ?? EdgeInsets.zero;
        final bottomInset = MediaQuery.of(context).padding.bottom + 16.h;
        final effectivePadding = basePadding.add(
          EdgeInsets.only(bottom: bottomInset),
        );

        Widget listView = ListView.separated(
          controller: _controller,
          padding: effectivePadding,
          itemCount: itemCount,
          itemBuilder: (ctx, index) {
            if (index < state.items.length) {
              return widget.itemBuilder(ctx, state.items[index], index);
            }
            // Footer
            if (state.isLoadingMore == true) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                child: Center(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 18.w,
                            height: 18.h,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          Gap(12.w),
                          Text(
                            'Loading more...',
                            style: context.textStyle.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            if (state.lastLoadMoreError == true) {
              final msg = state.lastLoadMoreErrorMessage;
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: Center(
                  child: Card(
                    color: Theme.of(context).colorScheme.surface,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (msg != null && msg.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  Gap(8.w),
                                  Flexible(
                                    child: Text(
                                      msg,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (widget.controller != null) {
                                widget.controller!.retry();
                              } else if (widget.onRetry != null) {
                                widget.onRetry!.call();
                              } else if (widget.bloc is PaginatedCubit<T>) {
                                (widget.bloc as PaginatedCubit<T>).retry();
                              }
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            if (state.hasMore == false) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'No more items',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
          separatorBuilder: (ctx, idx) =>
              widget.separatorBuilder?.call(ctx, idx) ??
              const SizedBox.shrink(),
        );

        // If pull-to-refresh is enabled, wrap the list in a RefreshIndicator.
        // When refreshing (state.isRefreshing) we show a small linear indicator at the top
        if (widget.enablePullToRefresh) {
          listView = RefreshIndicator(
            onRefresh: () {
              if (widget.controller != null)
                return widget.controller!.refresh();
              if (widget.onRefresh != null) return widget.onRefresh!();
              if (widget.bloc is PaginatedCubit<T>) {
                return (widget.bloc as PaginatedCubit<T>).refresh();
              }
              return Future.value();
            },
            child: Column(
              children: [
                if (state.isRefreshing == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(minHeight: 4),
                    ),
                  ),
                Expanded(child: listView),
              ],
            ),
          );
        }

        return listView;
      },
    );
  }
}

/// Simple skeleton list used while loading initial data.
class _SkeletonList extends StatelessWidget {
  const _SkeletonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      itemCount: 6,
      itemBuilder: (ctx, idx) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.06),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.06),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}

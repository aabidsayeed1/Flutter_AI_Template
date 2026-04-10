import 'package:flutter/foundation.dart';
import 'package:flutter_template_2025/core/logger/log.dart';
import 'package:flutter_template_2025/core/base/export.dart';
import 'package:flutter_template_2025/core/pagination/index.dart';

// (shared cubit is stored as a static field on the page state)

/// Demo index page hosting multiple demo pages/components.
class DemoIndexPage extends StatelessWidget {
  const DemoIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Demos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cubit'),
              Tab(text: 'Bloc'),
            ],
          ),
        ),
        body: TabBarView(
          children: [DemoPaginatedPage(), DemoPaginatedBlocPage()],
        ),
      ),
    );
  }
}

/// A page showing the paginated demo.
class DemoPaginatedPage extends StatefulWidget {
  const DemoPaginatedPage({super.key});

  @override
  State<DemoPaginatedPage> createState() => _DemoPaginatedPageState();
}

class _DemoPaginatedPageState extends State<DemoPaginatedPage> {
  // Shared cubit instance to persist list across navigations
  static final _sharedDemoCubit = _DemoStringPaginatedCubit(pageSize: 15);

  PaginatedCubit<String> get _cubit => _sharedDemoCubit;

  late final PaginatedController<String> _controller;

  @override
  void initState() {
    super.initState();
    _controller = PaginatedBlocAdapter.fromCubit(_sharedDemoCubit);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Cubit Demo',
                  style: context.textStyle.headlineSmall,
                ),
              ),
              Flexible(
                child: FilledButton(
                  onPressed: () => _sharedDemoCubit.loadInitial(),
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        StatefulBuilder(
          builder: (context, setState) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Simulate loadMore error'),
                Switch(
                  value: _sharedDemoCubit.simulateError,
                  onChanged: (v) {
                    _sharedDemoCubit.setSimulateError(v);
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
        Expanded(
          child: PaginatedListView<String>(
            bloc: _cubit,
            controller: _controller,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
            itemBuilder: (ctx, item, index) => Card(
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
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
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: context.textStyle.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item, style: context.textStyle.bodyLarge),
                            const SizedBox(height: 6),
                            Text(
                              'A neat 2026-style card item',
                              style: context.textStyle.bodySmall?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Demo paginated cubit (moved from ProfilePage)
class _DemoStringPaginatedCubit extends PaginatedCubit<String> {
  _DemoStringPaginatedCubit({super.pageSize = 20});
  bool simulateError = false;

  void setSimulateError(bool v) => simulateError = v;

  @override
  Future<PaginatedResult<String>> fetchPage(int page, int pageSize) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));
    // Demo: 5 pages
    const totalPages = 5;
    // Simulate an API error for demonstration when requested
    if (simulateError && page == 3) {
      throw Exception('Simulated network error on page $page');
    }
    if (page > totalPages) return PaginatedResult(items: [], hasMore: false);
    final items = List<String>.generate(
      pageSize,
      (i) => 'Item ${(page - 1) * pageSize + i + 1}',
    );
    final hasMore = page < totalPages;
    return PaginatedResult(items: items, hasMore: hasMore);
  }
}

// (Cubit instance is stored as a static on `_DemoPaginatedPageState` above.)

// ---------------------------------------------------------------------------
// Bloc-based demo
// ---------------------------------------------------------------------------

abstract class _DemoEvent {}

class _LoadInitialEvent extends _DemoEvent {}

class _LoadMoreEvent extends _DemoEvent {}

class _RefreshEvent extends _DemoEvent {}

class _RetryEvent extends _DemoEvent {}

class _DemoStringPaginatedBloc
    extends Bloc<_DemoEvent, PaginatedState<String>> {
  final int pageSize;
  bool simulateError = false;

  _DemoStringPaginatedBloc({this.pageSize = 20})
    : super(PaginatedState.initial()) {
    on<_LoadInitialEvent>(_onLoadInitial);
    on<_LoadMoreEvent>(_onLoadMore);
    on<_RefreshEvent>(_onRefresh);
    on<_RetryEvent>(_onRetry);
  }

  Future<PaginatedResult<String>> fetchPage(int page, int pageSize) async {
    await Future.delayed(const Duration(milliseconds: 800));
    const totalPages = 5;
    if (simulateError && page == 3) {
      throw Exception('Simulated network error on page $page');
    }
    if (page > totalPages) return PaginatedResult(items: [], hasMore: false);
    final items = List<String>.generate(
      pageSize,
      (i) => 'Item ${(page - 1) * pageSize + i + 1}',
    );
    final hasMore = page < totalPages;
    return PaginatedResult(items: items, hasMore: hasMore);
  }

  Future<void> _onLoadInitial(
    _LoadInitialEvent _,
    Emitter<PaginatedState<String>> emit,
  ) async {
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
      Log.error('DemoBloc.loadInitial failed: $e');
      if (kDebugMode) Log.error(st.toString());
      emit(
        state.copyWith(
          status: PaginatedStatus.error,
          error: e.toString(),
          isLoadingMore: false,
          isRefreshing: false,
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    _LoadMoreEvent _,
    Emitter<PaginatedState<String>> emit,
  ) async {
    if (!state.hasMore) return;
    if (state.isLoadingMore) {
      Log.debug(
        'DemoBloc._onLoadMore: already loading, ignoring duplicate event',
      );
      return;
    }
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
      final newItems = List<String>.from(state.items)..addAll(result.items);
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
      Log.error('DemoBloc.loadMore failed: $e');
      if (kDebugMode) Log.error(st.toString());
      final newState = state.copyWith(
        isLoadingMore: false,
        status: PaginatedStatus.success,
        lastLoadMoreError: true,
        lastLoadMoreErrorMessage: e.toString(),
      );
      Log.debug(
        'DemoBloc._onLoadMore emitting error state: page=${newState.page}, lastLoadMoreError=${newState.lastLoadMoreError}',
      );
      emit(newState);
    }
  }

  Future<void> _onRefresh(
    _RefreshEvent _,
    Emitter<PaginatedState<String>> emit,
  ) async {
    if (state.items.isEmpty) return _onLoadInitial(_LoadInitialEvent(), emit);
    emit(
      state.copyWith(isRefreshing: true, error: null, lastLoadMoreError: false),
    );
    try {
      final result = await fetchPage(1, pageSize);
      final existing = state.items;
      final newOnly = result.items.where((e) => !existing.contains(e)).toList();
      if (newOnly.isNotEmpty) {
        final updated = List<String>.from(newOnly)..addAll(existing);
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
      Log.error('DemoBloc.refresh failed: $e');
      if (kDebugMode) Log.error(st.toString());
      emit(state.copyWith(isRefreshing: false, error: e.toString()));
    }
  }

  Future<void> _onRetry(
    _RetryEvent _,
    Emitter<PaginatedState<String>> emit,
  ) async {
    Log.debug(
      'DemoBloc._onRetry called — lastLoadMoreError=${state.lastLoadMoreError}, status=${state.status}',
    );
    if (state.lastLoadMoreError) {
      Log.debug('DemoBloc._onRetry: dispatching LoadMoreEvent');
      add(_LoadMoreEvent());
      return;
    }
    if (state.status == PaginatedStatus.error) {
      Log.debug('DemoBloc._onRetry: dispatching LoadInitialEvent');
      add(_LoadInitialEvent());
    }
  }
}

// Bloc demo page
class DemoPaginatedBlocPage extends StatefulWidget {
  const DemoPaginatedBlocPage({super.key});

  @override
  State<DemoPaginatedBlocPage> createState() => _DemoPaginatedBlocPageState();
}

class _DemoPaginatedBlocPageState extends State<DemoPaginatedBlocPage> {
  static final _sharedDemoBloc = _DemoStringPaginatedBloc(pageSize: 15);

  _DemoStringPaginatedBloc get _bloc => _sharedDemoBloc;

  late final PaginatedController<String> _controller;

  @override
  void initState() {
    super.initState();
    _controller = PaginatedBlocAdapter<String>(
      bloc: _bloc,
      addLoadInitial: () => _bloc.add(_LoadInitialEvent()),
      addLoadMore: () => _bloc.add(_LoadMoreEvent()),
      addRefresh: () => _bloc.add(_RefreshEvent()),
      addRetry: () => _bloc.add(_RetryEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Bloc Demo',
                  style: context.textStyle.headlineSmall,
                ),
              ),

              Flexible(
                child: FilledButton(
                  onPressed: () {
                    _sharedDemoBloc.add(_LoadInitialEvent());
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        StatefulBuilder(
          builder: (context, setState) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Simulate loadMore error'),
                Switch(
                  value: _sharedDemoBloc.simulateError,
                  onChanged: (v) {
                    _sharedDemoBloc.simulateError = v;
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
        Expanded(
          child: PaginatedListView<String>(
            bloc: _bloc,
            controller: _controller,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
            itemBuilder: (ctx, item, index) => Card(
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
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
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: context.textStyle.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item, style: context.textStyle.bodyLarge),
                            const SizedBox(height: 6),
                            Text(
                              'A neat 2026-style card item (Bloc)',
                              style: context.textStyle.bodySmall?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

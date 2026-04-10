/// Abstraction for imperative paginated controls used by UI widgets.
///
/// Implement this to provide a simple controller surface for loading,
/// refreshing and retrying paginated flows. `PaginatedBlocAdapter` implements
/// this interface and can be used to bridge existing Blocs/Cubits.
abstract class PaginatedController<T> {
  Future<void> loadInitial();

  Future<void> loadMore();

  Future<void> refresh();

  void retry();
}

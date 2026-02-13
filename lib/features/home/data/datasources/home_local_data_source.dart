import '../models/home_model.dart';

abstract class HomeLocalDataSource {
  Future<List<HomeModel>> getCachedHomeItems();
  Future<void> cacheHomeItems(List<HomeModel> items);
}

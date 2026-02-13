import 'package:injectable/injectable.dart';

import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List<HomeEntity>> getHomeItems() async {
    final models = await remote.fetchHomeItems();
    return models; // HomeModel extends HomeEntity
  }
}

import 'package:injectable/injectable.dart';

import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/home_model.dart';
import '../services/network/home_api.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeApi api;

  HomeRepositoryImpl(this.api);

  @override
  Future<List<HomeEntity>> getHomeItems() async {
    final response = await api.getHomeItems();
    final List data = response.data as List;
    return data
        .map((e) => HomeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

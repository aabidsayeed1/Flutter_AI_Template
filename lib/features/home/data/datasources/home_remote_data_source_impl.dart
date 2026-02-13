import 'package:injectable/injectable.dart';

import '../models/home_model.dart';
import 'home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<HomeModel>> fetchHomeItems() async {
    // TODO: Replace with real API call
    return const [
      HomeModel(id: '1', title: 'Home Item 1'),
      HomeModel(id: '2', title: 'Home Item 2'),
      HomeModel(id: '3', title: 'Home Item 3'),
    ];
  }
}

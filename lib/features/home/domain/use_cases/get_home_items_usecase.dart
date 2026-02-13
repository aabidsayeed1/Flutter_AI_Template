import 'package:injectable/injectable.dart';

import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

@injectable
class GetHomeItemsUseCase {
  final HomeRepository repository;

  GetHomeItemsUseCase(this.repository);

  Future<List<HomeEntity>> call() {
    return repository.getHomeItems();
  }
}

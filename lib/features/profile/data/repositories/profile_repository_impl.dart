import 'package:injectable/injectable.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';
import '../services/network/profile_api.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApi api;

  ProfileRepositoryImpl(this.api);

  @override
  Future<ProfileEntity> getProfile() async {
    final response = await api.getProfile();
    return ProfileModel.fromJson(response.data as Map<String, dynamic>);
  }
}

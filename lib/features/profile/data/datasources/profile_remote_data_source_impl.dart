import 'package:injectable/injectable.dart';

import '../models/profile_model.dart';
import 'profile_remote_data_source.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileModel> fetchProfile() async {
    // TODO: Replace with real API call
    return const ProfileModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
    );
  }
}

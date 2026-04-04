import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'profile_endpoints.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) =
      _ProfileApi;

  @GET(ProfileEndpoints.profile)
  Future<HttpResponse> getProfile();
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/login_model.dart';
import 'auth_endpoints.dart';

part 'auth_api.g.dart';

/// Retrofit API client for authentication feature.
///
/// Each feature should define its own `@RestApi` class
/// (e.g., `HomeApi`, `ProfileApi`) and register it with get_it
/// using the shared [Dio] instance.
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) =
      _AuthApi;

  @POST(AuthEndpoints.login)
  Future<HttpResponse> login(@Body() LoginRequestModel request);
}

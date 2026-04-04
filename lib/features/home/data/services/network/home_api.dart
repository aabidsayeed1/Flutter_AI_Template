import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'home_endpoints.dart';

part 'home_api.g.dart';

@RestApi()
abstract class HomeApi {
  factory HomeApi(Dio dio, {String? baseUrl, ParseErrorLogger errorLogger}) =
      _HomeApi;

  @GET(HomeEndpoints.homeItems)
  Future<HttpResponse> getHomeItems();
}

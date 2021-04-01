import 'package:json_annotation/json_annotation.dart';
import 'package:libapp_demo/model/userInfo.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'data.dart';

part 'rest_client.g.dart';

class Apis {
//no auth api
  static const String login = '/login/login';
  static const String checkUser = '/login/checkUser';
  static const String putUser = '/login/putUser';

//auth api

}

@RestApi(baseUrl: "http://192.168.1.5:50005/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(Apis.login)
  Future<ResponseData> login(@Body() UserInfo userInfo);

  @GET(Apis.checkUser)
  Future<ResponseData> checkUser(@Header("kakao_id")String kakao_id);

  @PUT(Apis.putUser)
  Future<ResponseData> putUser(@Body() UserInfo userInfo);

}

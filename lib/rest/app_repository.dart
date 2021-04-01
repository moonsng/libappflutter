import 'package:dio/dio.dart';
import 'package:libapp_demo/rest/rest_client.dart';

class AppRepository {
  RestClient _restClient;
  Dio dio;

  AppRepository() {
    dio = Dio();
    _restClient = RestClient(dio);
  }
}
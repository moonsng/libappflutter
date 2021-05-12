import 'package:dio/dio.dart';
import 'package:libapp_demo/rest/third_party_client.dart';

class ThidPartyAppRepository {
  ThridPartyClient _thridPartyClient;
  Dio dio;

  ThidPartyAppRepository() {
    dio = Dio();
    _thridPartyClient = ThridPartyClient(dio);
  }
}
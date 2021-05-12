import 'package:json_annotation/json_annotation.dart';
import 'package:libapp_demo/model/userInfo.dart';
import 'package:libapp_demo/view/alert.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'data.dart';
part 'third_party_client.g.dart';


class ThirdPartyApis {
  static const String getBookInfoByIsbn = '/srchDtlList/';
  static const String libSrch = '/libSrch/';
  static const String loanItemSrchByLib = '/loanItemSrch/';
}

@RestApi(baseUrl: "http://data4library.kr/api/")
abstract class ThridPartyClient {
  factory ThridPartyClient(Dio dio, {String baseUrl}) = _ThridPartyClient;

  @GET(ThirdPartyApis.getBookInfoByIsbn)
  Future<dynamic> getBookInfoByIsbn(@Query("authKey") String key, @Query("isbn13") String isbn13);

  @GET(ThirdPartyApis.libSrch)
  Future<dynamic> getLibInfo(@Query("authKey") String key, @Query("libCode") String libCode);

  @GET(ThirdPartyApis.loanItemSrchByLib)
  Future<dynamic> getLoanInfo(@Query("authKey") String key, @Query("region") String region);

  

}

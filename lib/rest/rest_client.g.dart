// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.5:50005/api/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseData> login(userInfo) async {
    ArgumentError.checkNotNull(userInfo, 'userInfo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userInfo?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/login/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> checkUser(kakao_id) async {
    ArgumentError.checkNotNull(kakao_id, 'kakao_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/login/checkUser',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'kakao_id': kakao_id},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseData> putUser(userInfo) async {
    ArgumentError.checkNotNull(userInfo, 'userInfo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userInfo?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/login/putUser',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseData.fromJson(_result.data);
    return value;
  }
}

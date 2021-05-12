// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ThridPartyClient implements ThridPartyClient {
  _ThridPartyClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://data4library.kr/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<dynamic> getBookInfoByIsbn(key, isbn13) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(isbn13, 'isbn13');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'authKey': key,
      r'isbn13': isbn13
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request('/srchDtlList/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> getLibInfo(key, libCode) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(libCode, 'libCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'authKey': key,
      r'libCode': libCode
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request('/libSrch/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> getLoanInfo(key, region) async {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(region, 'region');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'authKey': key,
      r'region': region
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request('/loanItemSrch/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}

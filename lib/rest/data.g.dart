// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return ResponseData(
    message: json['message'] as String,
    status: json['status'] as int,
    code: json['code'] as String,
    meta: json['meta'],
    data: json['data'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'meta': instance.meta,
      'data': instance.data,
    };

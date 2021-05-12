// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibInfo _$LibInfoFromJson(Map<String, dynamic> json) {
  return LibInfo(
    no: json['no'] as String,
    libCode: json['libCode'] as String,
    libName: json['libName'] as String,
    tel: json['tel'] as String,
    address: json['address'] as String,
    homepage: json['homepage'] as String,
    closed: json['closed'] as String,
    operatingTime: json['operatingTime'] as String,
  );
}

Map<String, dynamic> _$LibInfoToJson(LibInfo instance) => <String, dynamic>{
      'no': instance.no,
      'libCode': instance.libCode,
      'libName': instance.libName,
      'address': instance.address,
      'tel': instance.tel,
      'homepage': instance.homepage,
      'closed': instance.closed,
      'operatingTime': instance.operatingTime,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loanInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanInfo _$LoanInfoFromJson(Map<String, dynamic> json) {
  return LoanInfo(
    no: json['no'] as String,
    region: json['region'] as String,
    bookname: json['bookname'] as String,
    authors: json['authors'] as String,
    bookImageURL: json['bookImageURL'] as String,
  );
}

Map<String, dynamic> _$LoanInfoToJson(LoanInfo instance) => <String, dynamic>{
      'no': instance.no,
      'region': instance.region,
      'bookname': instance.bookname,
      'authors': instance.authors,
      'bookImageURL': instance.bookImageURL,
    };

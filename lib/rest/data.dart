import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class ResponseData{
  String message;
  int status;
  String code;
  dynamic meta;
  Map<String, dynamic> data;
  ResponseData({this.message, this.status, this.code, this.meta, this.data});
  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'libInfo.g.dart';

@JsonSerializable()
class LibInfo {
  String no;
  String libCode;
  String libName;
  String address;
  String tel;
  String homepage;
  String closed;
  String operatingTime;

  LibInfo({
    this.no,
    this.libCode,
    this.libName,
    this.tel,
    this.address,
    this.homepage,
    this.closed,
    this.operatingTime,
  });

  factory LibInfo.fromJson(Map<String, dynamic> json) => _$LibInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LibInfoToJson(this);

}

import 'package:json_annotation/json_annotation.dart';

part 'loanInfo.g.dart';

@JsonSerializable()
class LoanInfo {
  String no;
  String region;
  String bookname;
  String authors;
  String bookImageURL;

  LoanInfo({
    this.no,
    this.region,
    this.bookname,
    this.authors,
    this.bookImageURL,
  });

  factory LoanInfo.fromJson(Map<String, dynamic> json) => _$LoanInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoanInfoToJson(this);

}

import 'package:json_annotation/json_annotation.dart';

part 'bookInfoByIsbn.g.dart';

@JsonSerializable()
class BookInfoByIsbn {
  String no;
  String bookname;
  String publication_date;
  String authors;
  String publisher;
  String class_no;
  String publication_year;
  String bookImageURL;
  String isbn;
  String isbn13;
  String description;

  BookInfoByIsbn({
      this.no,
      this.bookname,
      this.publication_date,
      this.authors,
      this.publisher,
      this.class_no,
      this.publication_year,
      this.bookImageURL,
      this.isbn,
      this.isbn13,
      this.description});

  factory BookInfoByIsbn.fromJson(Map<String, dynamic> json) => _$BookInfoByIsbnFromJson(json);
  Map<String, dynamic> toJson() => _$BookInfoByIsbnToJson(this);

}

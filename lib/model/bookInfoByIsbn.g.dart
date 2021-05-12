// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookInfoByIsbn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookInfoByIsbn _$BookInfoByIsbnFromJson(Map<String, dynamic> json) {
  return BookInfoByIsbn(
    no: json['no'] as String,
    bookname: json['bookname'] as String,
    publication_date: json['publication_date'] as String,
    authors: json['authors'] as String,
    publisher: json['publisher'] as String,
    class_no: json['class_no'] as String,
    publication_year: json['publication_year'] as String,
    bookImageURL: json['bookImageURL'] as String,
    isbn: json['isbn'] as String,
    isbn13: json['isbn13'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$BookInfoByIsbnToJson(BookInfoByIsbn instance) =>
    <String, dynamic>{
      'no': instance.no,
      'bookname': instance.bookname,
      'publication_date': instance.publication_date,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'class_no': instance.class_no,
      'publication_year': instance.publication_year,
      'bookImageURL': instance.bookImageURL,
      'isbn': instance.isbn,
      'isbn13': instance.isbn13,
      'description': instance.description,
    };

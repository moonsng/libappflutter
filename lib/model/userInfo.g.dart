// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    email: json['email'] as String,
    gender: json['gender'] as String,
    age_range: json['age_range'] as String,
    name: json['name'] as String,
    fcm_token: json['fcm_token'] as String,
    push_agree: json['push_agree'] as String,
    is_login: json['is_login'] as String,
    is_delete: json['is_delete'] as String,
    reg_date: json['reg_date'] as String,
    modi_date: json['modi_date'] as String,
    idx: json['idx'] as int,
    role: json['role'] as String,
    last_login_date: json['last_login_date'] as String,
    kakao_id: json['kakao_id'] as String,
    password: json['password'] as String,
    jwt: json['jwt'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'email': instance.email,
      'gender': instance.gender,
      'age_range': instance.age_range,
      'name': instance.name,
      'fcm_token': instance.fcm_token,
      'push_agree': instance.push_agree,
      'is_login': instance.is_login,
      'is_delete': instance.is_delete,
      'reg_date': instance.reg_date,
      'modi_date': instance.modi_date,
      'idx': instance.idx,
      'role': instance.role,
      'last_login_date': instance.last_login_date,
      'kakao_id': instance.kakao_id,
      'password': instance.password,
      'jwt': instance.jwt,
    };

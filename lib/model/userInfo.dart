import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
  String email;
  String gender;
  String age_range;
  String name;
  String fcm_token;
  String push_agree;
  String is_login;
  String is_delete;
  String reg_date;
  String modi_date;
  int idx;
  String role;
  String last_login_date;
  String kakao_id;
  String password;
  String jwt;

  UserInfo({this.email, this.gender, this.age_range, this.name, this.fcm_token, this.push_agree, this.is_login, this.is_delete, this.reg_date, this.modi_date, this.idx, this.role, this.last_login_date, this.kakao_id, this.password, this.jwt});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
 /* {
    return UserInfo (
      email: json['email'],
      gender: json['gender'],
      age_range: json['age_range'],
      name: json['name'],
      fcm_token: json['fcm_token'],
      push_agree: json['push_agree'],
      is_login: json['is_login'],
      is_delete: json['is_delete'],
      reg_date: json['reg_date'],
      modi_date: json['modi_date'],
      idx: json['idx'],
      role: json['role'],
      last_login_date: json['last_login_date'],
      kakao_id: json['kakao_id'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'gender': gender,
      'age_range': age_range,
      'name': name,
      'fcm_token': fcm_token,
      'push_agree': push_agree,
      'is_login': is_login,
      'is_delete': is_delete,
      'reg_date': reg_date,
      'modi_date': modi_date,
      'idx': idx,
      'role': role,
      'last_login_date': last_login_date,
      'kakao_id': kakao_id,
      'password': password,
    };
  }*/
}

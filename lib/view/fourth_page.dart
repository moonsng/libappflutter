import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libapp_demo/main.dart';
import 'dart:async';

import 'package:libapp_demo/question/first.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FourthApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FourthApp();
}

class _FourthApp extends State<FourthApp> {
  bool pushCheck = true;

  @override
  void initState() {
    super.initState();
    _FourthApp();
  }

  void kakaoLogout() async {
    try {
      final FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
      await kakaoSignIn.init('67b28dcf93f4e1b7f0394a739d657a80');
      final result = await kakaoSignIn.unlink();

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.clear();

      Navigator.popUntil(context, ModalRoute.withName("/"));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => KakaoLoginPage()));
    } on PlatformException catch (e) {
      print("${e.code} ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_alert_outlined),
            title: Text('푸시 알림 설정'),
            trailing: Switch(
              value: pushCheck,
              onChanged: (value) {
                setState(
                  () {
                    pushCheck = value;
                  },
                );
              },
              activeColor: Colors.teal,
            ),
          ),
          Divider(height: 5.0, color: Colors.black),
          ListTile(
            leading: Icon(Icons.local_library),
            title: Text('도서관 설정'),
            trailing: OutlinedButton(
              child: Text('수정하기'),
              onPressed: () {},
            ),
          ),
          Divider(height: 5.0, color: Colors.black),
          ListTile(
            leading: Icon(Icons.thumb_up),
            title: Text('추천정보 설정'),
            trailing: OutlinedButton(
              child: Text('수정하기'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Question()));
              },
            ),
          ),
          Divider(height: 5.0, color: Colors.black),
          ListTile(
            leading: Icon(Icons.warning_rounded),
            title: Text('신고하기'),
          ),
          Divider(height: 5.0, color: Colors.grey),
          ListTile(
          //  leading: Icon(Icons.person),
            title: TextButton(
              child: Text('로그아웃'),
              onPressed: () {
                kakaoLogout();
              },
            ),
          ),
          Divider(height: 5.0, color: Colors.black),
        ],
      ),
    );
  }
}
//  value: pushCheck,
//   onChanged: (value) {
//  setState(() {
//  pushCheck = value;

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libapp_demo/main.dart';
import 'dart:async';
import 'package:libapp_demo/question/first.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:libapp_demo/rest/third_party_client.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:libapp_demo/model/libInfo.dart';
import 'package:xml2json/xml2json.dart';

final logger = Logger();

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
            leading: Icon(Icons.notifications,color: Colors.black),
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
            leading: Icon(Icons.local_library,color: Colors.black),
            title: Text('도서관 설정'),
            trailing: OutlinedButton(
              child: Text('수정하기', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SetLib()));
              },
            ),
          ),
          Divider(height: 5.0, color: Colors.black),
          ListTile(
            leading: Icon(Icons.thumb_up,color: Colors.black),
            title: Text('추천정보 설정'),
            trailing: OutlinedButton(
              child: Text('수정하기', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Question()));
              },
            ),
          ),
          Divider(height: 5.0, color: Colors.black),
          ListTile(
            leading: Icon(Icons.warning_rounded,color: Colors.black),
            title: Text('신고하기'),
          ),
          Divider(height: 5.0, color: Colors.black),
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

class SetLib extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SetLib();
  // final fourthPartyClient = FourthPartyClient(Dio(BaseOptions(headers: {
  // 'contentType': "application/xml",
  // 'Access-Control-Allow-Origin': 'true',
  // }
  // )));
}

class _SetLib extends State<SetLib> {
  int value = 1;

  String no;
  String libCode = '';
  String libName = '';
  String address = '';
  String tel = '';
  String homepage = '';
  String closed = '';
  String operatingTime = '';

  var _ischecked = false;
  final List<LibInfo> entries = <LibInfo>[];

  final thidPartyClient = ThridPartyClient(Dio(BaseOptions(headers: {
    'contentType': "application/xml",
    'Access-Control-Allow-Origin': 'true',
  })));

  Future<void> getLibInfoList() async {
    thidPartyClient
        .getLibInfo(
        '1a720ade31df7d25f022cb0afe64a14f1d1827a4bc349887f5434fe48901cab0',
        '130023')
        .then((value) => {parseLibData(value.toString())});
  }

  void parseLibData(String libDataString) async {
    final myTransformer = Xml2Json();
    myTransformer.parse(libDataString);
    var json = myTransformer.toParker();
    Map<String, dynamic> data = jsonDecode(json);
    LibInfo libInfo = LibInfo.fromJson(data["response"]["libs"]["lib"]);
    logger.i(libInfo.toJson());

    setState(() {
      this.libCode = libInfo.libCode;
      this. libName = libInfo.libName;
      this. address = libInfo.address;
      this. tel = libInfo.tel;
      this. homepage = libInfo.homepage;
      this. closed = libInfo.closed;
      this. operatingTime = libInfo.operatingTime;
    });
    // setState(() {
    //   libList;
    // });
  }
  @override
  void initState() {
    super.initState();
    getLibInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
            title: Text('도서관설정페이지'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: value,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 300,
                        width: double.maxFinite,
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 5.0, color: Colors.grey),
                              //  bottom: BorderSide(width: 5.0, color: Colors.grey),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(7),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Row(children: [
                                                Text(this.libName,
                                                    style: TextStyle(
                                                        fontSize: 25)),
                                                Spacer(),
                                                Checkbox(
                                                  value: _ischecked,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _ischecked = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ]),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,),
                                                  Text(this.address),
                                                  SizedBox(
                                                    height: 20,),
                                                  Text(this.tel),
                                                  SizedBox(
                                                    height: 20,),
                                                  Text(this.homepage),
                                                  SizedBox(
                                                    height: 20,),
                                                  Text(this.closed + "\n" +this.operatingTime),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:libapp_demo/model/userInfo.dart';
import 'package:libapp_demo/rest/rest_client.dart';
import 'package:libapp_demo/view/main_page.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

final logger = Logger();
final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

void login(BuildContext context, String kakao_id, String password){
  client.login(UserInfo(kakao_id: kakao_id, password: password, fcm_token: "test"))
      .then((responseData) => loginSuccess(context, responseData.toJson()));
}

void loginSuccess(BuildContext context, Map<String, dynamic> data) async{
  String jwt = data["message"];
  UserInfo userInfo = UserInfo.fromJson(data["data"]["UserInfo"]);
  userInfo.jwt = jwt;
  logger.i(data);
  logger.i(userInfo.toJson());

  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("userInfo", jsonEncode(userInfo));

  if(context != null) {
    moveToMainPage(context);
  }
}

void moveToMainPage(BuildContext context){
  Navigator.of(context).pop();
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage(title: 'main',)));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();

  Future<Widget> loadFromFuture() async {
    bool isDebug = false;
    if(isDebug){
      return Future.value(new MainPage(title: "home",));
    }else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userInfoString = pref.get("userInfo");


      if (userInfoString != null) { //내부저장소에 로그인 정보가 있을 경우 메인 페이지로 이동.
        //'1638364656'
        UserInfo userInfo = UserInfo.fromJson(jsonDecode(userInfoString));
        String kakao_id = userInfo.kakao_id;
        String password = sha256.convert(utf8.encode(kakao_id)).toString();

        await client.login(
            UserInfo(kakao_id: kakao_id, password: password, fcm_token: 'test'))
            .then((responseData) => loginSuccess(null, responseData.toJson()));

        //메인페이지 이동
        return Future.value(new MainPage(title: "home",));
      } else {
        //내부저장소에 로그인 정보가 없을 경우 카카오 로그인 페이지로 이동
        return Future.value(new KakaoLoginPage());
      }
    }
  }

  void login(BuildContext context, String kakao_id, String password){
    client.login(UserInfo(kakao_id: kakao_id, password: password, fcm_token: "test"))
        .then((responseData) => loginSuccess(context, responseData.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        navigateAfterFuture: loadFromFuture(),
        title: new Text('Welcome In SplashScreen',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.red
    );
  }
  @override
  Future<void> State() async {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['data']['title']),
              subtitle: Text(message['data']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['data']['title']),
              subtitle: Text(message['data']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}



class KakaoLoginPage extends StatelessWidget {

  static final FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();

  void kakaoLogin(BuildContext context) async {
    await kakaoSignIn.init('67b28dcf93f4e1b7f0394a739d657a80');
    final hashKey = await kakaoSignIn.hashKey;
    print('hashKey: $hashKey');
    try {
      final result = await kakaoSignIn.logIn();
      switch (result.status) {
        case KakaoLoginStatus.loggedIn:
          final result = await kakaoSignIn.getUserMe();
          client.checkUser(result.account.userID).then((responseData) => checkUser(context, result, responseData.toJson()));
          break;
        case KakaoLoginStatus.loggedOut:
          break;
        case KakaoLoginStatus.unlinked:
          break;
      }
    } on PlatformException catch (e) {
      logger.i('${e.code} ${e.message}');
    }
  }

  void checkUser(BuildContext context, final result, Map<String, dynamic> data){
    logger.i(data);
    String kakao_id = result.account.userID;
    String password = sha256.convert(utf8.encode(kakao_id)).toString();

    if("find" == data["message"]){ //이미 존재하는 유저일 경우 로그인
      login(context, kakao_id, password);
    }else if("not_find" == data["message"]){//존재하지 않는 유저일 경우 회원가입
      join(context, result, kakao_id, password);
    }
  }

  void join(BuildContext context, final result, String kakao_id, String password){
    UserInfo userInfo = new UserInfo();
    userInfo.kakao_id = kakao_id;
    userInfo.password = password;
    userInfo.email = result.account.userEmail;
    userInfo.gender = result.account.userGender;
    userInfo.age_range = result.account.userAgeRange;
    userInfo.name = result.account.userNickname;
    userInfo.fcm_token = 'test1234';
    userInfo.push_agree = '0';
    userInfo.is_login = '0';
    userInfo.is_delete = '0';
    userInfo.role = 'ROLE_USER';
    client.putUser(userInfo).then((responseData) => login(context, kakao_id, password));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("로그인페이지"),
          automaticallyImplyLeading: true),
      body: new Center(
        child: new OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.amber,
            ),
          ),
          onPressed: () {
            kakaoLogin(context);
          },
          child: Text('카카오톡 로그인',
            style: new TextStyle(fontSize: 20.0, color: Colors.white),),
        ),
      ),
    );
  }
}
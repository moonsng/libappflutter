import 'package:flutter/material.dart';
import 'package:libapp_demo/view/alert.dart';
import 'package:libapp_demo/view/first_page.dart';
import 'package:libapp_demo/view/fourth_page.dart';
import 'package:libapp_demo/view/second_page.dart';
import 'package:libapp_demo/view/third_page.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:badges/badges.dart';

final logger = Logger();

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isPushMessage = false;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging
        .getToken()
        .then((value) => {logger.i("fcmtoken : " + value)});
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          isPushMessage = true;
        });

        print('onMessage: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              // title: Text(message['data']['title']),
              // subtitle: Text(message['data']['body']),
              title: Text("title"),
              subtitle: Text("subtitle"),
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
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      if (!controller.indexIsChanging) {
        print("이전 index, ${controller.previousIndex}");
        print("현재 index, ${controller.index}");
        print("전체 탭 길이, ${controller.length}");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('libraryApp_demo'),
          actions: <Widget>[
             _AlarmBadge(),
          ],
          backgroundColor: Colors.teal,
        ),
        body: TabBarView(
          children: <Widget>[
            FirstApp(),
            SecondApp(),
            ThirdApp(title: "ThirdApp"),
            FourthApp(),
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.transparent,
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.home),
              text: ('홈'),
            ),
            Tab(
              icon: Icon(Icons.search),
              text: ('도서검색'),
            ),
            Tab(
              icon: Icon(Icons.library_books),
              text: ('공유서가'),
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: ('설정'),
            )
          ],
          controller: controller,
        ));
  }
  Widget _AlarmBadge() {
    return Badge(
      showBadge: isPushMessage ? true : false,
      animationType: BadgeAnimationType.scale,
      position: BadgePosition.topEnd(top: 15, end: 15),
      child: IconButton(
          icon: Icon(Icons.notifications_sharp),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => alertList()));
            setState(() {
              isPushMessage = false;
            });
          }),
    );
  }
}

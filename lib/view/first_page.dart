import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MaterialApp(
        home: Scaffold(
         body: FirstApp(),
    )));

class FirstApp extends StatefulWidget {
  @override
  _FirstAppState createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int _currentIndex = 0;
  List<String> imgList = ['https://img.ridicdn.net/cover/443000842/xxlarge'];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
            child: Text(
              '앱 사용자를 위한 추천도서',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 20 / 9,
              height: 300.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 600,
                      )),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlinedButton(
                onPressed: () {

                },
                child: Text('상세정보'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
}
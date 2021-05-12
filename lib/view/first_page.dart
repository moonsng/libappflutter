import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:libapp_demo/model/loanInfo.dart';
import 'package:libapp_demo/rest/third_party_client.dart';
import 'package:xml2json/xml2json.dart';
import '../main.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  String no;
  String region;
  String bookname = '';
  String authors = '';
  String bookImageURL = '';

  final List<LoanInfo> entries = <LoanInfo>[];
  final thidPartyClient = ThridPartyClient(Dio(BaseOptions(headers: {
    'contentType': "application/xml",
    'Access-Control-Allow-Origin': 'true',
  })));
  Future<void> getLoanInfoList() async {
    thidPartyClient
        .getLoanInfo(
        '1a720ade31df7d25f022cb0afe64a14f1d1827a4bc349887f5434fe48901cab0',
        '25')
        .then((value) => {parseLoanData(value.toString())});
  }
    void parseLoanData(String loanDataString) async {
    final myTransformer = Xml2Json();
    myTransformer.parse(loanDataString);
    var json = myTransformer.toParker();
    Map<String, dynamic> data = jsonDecode(json);
    LoanInfo loanInfo = LoanInfo.fromJson(data["response"]["docs"]["doc"]);
    logger.i(loanInfo.toJson());

    setState(() {
      this.region = loanInfo.region;
      this.bookname = loanInfo.bookname;
      this.authors = loanInfo.authors;
      this.bookImageURL = loanInfo.bookImageURL;
    });
  }
  @override
  void initState(){
    super.initState();
    getLoanInfoList();
  }

  int _currentIndex = 0;
  List<String> imgList = ['bookImageURL'];
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
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    child: ClipRect(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.1),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Text(
                                  '앱 사용자를 위한 추천도서',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 20 / 9,
                                  height: 300.0,
                                  autoPlay: false,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  pauseAutoPlayOnTouch: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                                items: imgList.map((item) =>
                                    Container(
                                      child: Center(
                                        child: Image.network(
                                         item,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                              ),
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Text(
                                  '도서관 인기 대출도서',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                  ),
                  child: Image.network(
                    bookImageURL.trim(),

                    fit: BoxFit.fill,
                  ),
                ),
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text('Row')
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
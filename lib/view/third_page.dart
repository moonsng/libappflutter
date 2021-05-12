import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libapp_demo/model/bookInfoByIsbn.dart';
import 'package:libapp_demo/rest/third_party_client.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:xml/xml.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:xml2json/xml2json.dart';

final logger = Logger();

class ThirdApp extends StatefulWidget {
  ThirdApp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ThirdApp createState() => _ThirdApp();
}
class _ThirdApp extends State<ThirdApp> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
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
        body: new TabBarView(
          children: <Widget>[
            Mine(),
            Neighbor(),
            Share(),
          ],
          controller: controller,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
         child: new AppBar(
            backgroundColor: Colors.teal[50],
            bottom: new TabBar(
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black38,
              indicatorColor: Colors.teal,
              tabs: <Tab>[
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: '전체 서가',
                ),
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: '내서가',
                ),
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: '공유목록',
                ),
              ],
              controller: controller,
            ))));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
//전체서재 페이지
class Mine extends StatelessWidget {
  final words = [];

  var switchValue = false;
  String test = '신청';
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('도서데이터가져오기'),
            onTap: (){
              //내비게이터푸쉬로 다음 화면 넘기기, 데이터 넘기기
            },
            trailing: OutlinedButton(
              //child: Text('신청'),
              onPressed: () {
                final snackBar = SnackBar(
                 duration:Duration(seconds: 3),
                 content: Text('공유 신청완료!'),
                 action: SnackBarAction(
                label: '닫기',
                onPressed: (){},
                ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('신청'),
            ),
          );
        },
      ),
    );
  }

  void setState(Null Function() param0) {}
}

//내서재 페이지
class Neighbor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                TextButton(
                  child: Text('공유 신청 도서목록'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//공유목록 페이지
class Share extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
final thidPartyClient = ThridPartyClient(Dio(BaseOptions(headers: {
  'contentType': "application/xml",
  'Access-Control-Allow-Origin': 'true',
})));

class _MyAppState extends State<Share> {
  int value = 1;
  String title = '도서명';
  String authors = ' 저자';
  String publisher = '출판사';
  String publication_year = '출판년도';
  String bookImageURL = "이미지";

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          child: Center(
              child: ListView.builder(
               itemCount: this.value,
               itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Row(
                    children: <Widget>[
                       Expanded(
                        child: Image.network(
                         bookImageURL.trim(),
                         height: 100,
                         width: 100,
                         fit: BoxFit.contain,
                       ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              authors,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              publisher,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              publication_year,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scan(),
          tooltip: 'scan',
          child: const Icon(
            Icons.camera_alt,
          ),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }

  Future<void> _scan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    thidPartyClient
        .getBookInfoByIsbn(
            '1a720ade31df7d25f022cb0afe64a14f1d1827a4bc349887f5434fe48901cab0',
            barcodeScanRes)
        .then((value) => {parseBookData(value.toString())});
  }

  void parseBookData(String bookDataString) async {
    final myTransformer = Xml2Json();
    myTransformer.parse(bookDataString);
    var json = myTransformer.toParker();
    Map<String, dynamic> data = jsonDecode(json);
    BookInfoByIsbn bookInfo =
        BookInfoByIsbn.fromJson(data["response"]["detail"]["book"]);
    logger.i(bookInfo.toJson());

    setState(() {
      title = bookInfo.bookname;
      authors = bookInfo.authors;
      publisher = bookInfo.publisher;
      publication_year = bookInfo.publication_year;
      bookImageURL = bookInfo.bookImageURL;
    });
  }
}

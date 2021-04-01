import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
        appBar: new AppBar(
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
            )));
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
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  var switchValue = false;
  String test = '신청';
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        final disp_text = ' $index  ';

        return Card(
            child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 150,
              child: Text(
                '  $index',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  _color,
                ),
              ),
              child: Text('$test'),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false, //바깥영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('신청완료!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('공유서가에서 도서를 찾아가세요'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('닫기'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            )
          ],
        ));
      }),
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
                FlatButton(
                  color: Colors.teal[50],
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

class Share extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.bottomRight,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Icon(Icons.camera_alt),
                            backgroundColor: Colors.teal,
                        ),
                      ]));
            })));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;
    //
    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    //});
  }
}
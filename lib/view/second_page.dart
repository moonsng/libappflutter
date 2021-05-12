import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SecondApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondApp();
}

class _SecondApp extends State<SecondApp> {
  launchButton(String buttonText, String url) {
    return TextButton(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'could not';
        }
      },
      child: Text(buttonText),
    );
  }

  String result = '';
  TextEditingController _editingController;
  ScrollController _scrollController;
  List data;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = [];
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('bottom');
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '책제목,작가명으로 찾을 수 있어요'),
        ),
      ),
      body: Container(
        child: Center(
          child: data.length == 0
              ? Text(
            '데이터가 존재하지 않습니다.\n검색해주세요',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
              : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        data[index]['thumbnail'],
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      Expanded(
                      child:Column(
                        children: <Widget>[
                         Container(
                           width:
                           MediaQuery.of(context).size.width - 150,
                            child: Text(
                              data[index]['title'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                              '저자 : ${data[index]['authors'].toString()}'
                          ),
                          Text(
                              '출판사 : ${data[index]['publisher'].toString()}'
                          ),
                        ],
                      )
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
              );
            },
            itemCount: data.length,
            controller: _scrollController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          page = 1;
          data.clear();
          getJSONData();
        },
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Future<String> getJSONData() async {
    var url =
        'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController.value.text}';

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Authorization": "KakaoAK 7c95f1efe4b61b8ec3dc4d1d18b94204"});

    print(response.body); // 검색 결과 로그창으로 확인

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data.addAll(result);
    });
    return response.body;
  }

}
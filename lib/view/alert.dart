import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class alertList extends StatefulWidget {
  @override
  _alertListState createState() => _alertListState();
}

class _alertListState extends State<alertList> {
  launchButton(String buttonText, String url) {
    return OutlinedButton(
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

  // deleteItem(int index){
  //  yourList.removeWhere(index);
  // }
  //
  // yourList() {
  //   setState(() {
  //     //리스트 데이터 입력
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림목록'),
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context , index) {
            return ListTile(
              title: launchButton('알림 내용(공지)','https://www.gplib.or.kr/bbs/list/1'),
              trailing: OutlinedButton(
                onPressed: () {
                 // deleteItem(index);
                },
                child: Icon(Icons.delete_forever),
              ),
            );
          }),
        ),
      ),
    );
  }
}

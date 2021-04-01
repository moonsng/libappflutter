import 'package:flutter/material.dart';
import 'package:libapp_demo/question/last.dart';
import 'package:libapp_demo/view/first_page.dart';
import 'package:libapp_demo/view/main_page.dart';
import 'package:libapp_demo/question/first.dart';


class Question_second extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Question_second();
}

class _Question_second extends State<Question_second> {

  final _items = ['개혁가', '조력가', '성취자', '예술가','사색가','충성가','낙천가','지도자','중재자'];
  var _selected = '개혁가';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('질문지'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '2. 성격유형을 알려주세요',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 100,
                ),
                ],
            ),
            Text(
              '< 에니어그램 유형 >',

            ),
                DropdownButton(
                  underline: Container(
                    height: 2,
                    color: Colors.orange,
                  ),
                  iconEnabledColor: Colors.orange,
                  value: _selected,
                  items: _items.map(
                          (value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value)
                        );
                      }
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selected = value.toString();
                    });
                  },
                ),
            SizedBox(
              height: 50,
            ),
            Divider(height: 5.0, color: Colors.black),
            SizedBox(
              height: 50,
            ),
           TextButton(
              child: Text('이전'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Question()));
              },
            ),
            OutlinedButton(
              child: Text('다음'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Question_last()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
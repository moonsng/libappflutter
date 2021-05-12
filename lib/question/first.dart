import 'package:flutter/material.dart';
import 'package:libapp_demo/question/second.dart';
import 'package:libapp_demo/view/first_page.dart';
import 'package:libapp_demo/view/main_page.dart';

enum Gender{MAN, WOMEN}

class Question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Question();
}

class _Question extends State<Question> {
  Gender _gender = Gender.MAN;
  final _items = ['10대', '20대', '30대', '40대','50대','60대 이상'];
  var _selected = '10대';

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
                  '1. 성별과 연령대를 알려주세요',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
            ListTile(
              title: Text('남자'),
              leading: Radio(
                value: Gender.MAN,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = (value == Gender.MAN) ? Gender.MAN : Gender.WOMEN;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('여자'),
              leading: Radio(
                value: Gender.WOMEN,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = (value == Gender.MAN) ? Gender.MAN : Gender.WOMEN;
                  });
                },
              ),
            ),
            SizedBox(
              height: 50,
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
                  //_selected = value;
                });
              },
            ),
            Divider(height: 5.0, color: Colors.black),
            SizedBox(
              height: 50,
            ),
            OutlinedButton(
              child: Text('다음'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Question_second()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
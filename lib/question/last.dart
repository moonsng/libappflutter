import 'package:flutter/material.dart';
import 'package:libapp_demo/view/first_page.dart';
import 'package:libapp_demo/view/main_page.dart';
import 'package:libapp_demo/question/second.dart';


class Question_last extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Question_last();
}

class _Question_last extends State<Question_last> {

  final _items = ['감정1', '감정2', '감정3'];
  var _selected = '감정1';

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
                  '3.요즘의 기분을 알려주세요',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
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
                    MaterialPageRoute(builder: (context) => Question_second()));
              },
            ),
            OutlinedButton(
              child: Text('완료'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (BuildContext context)=>
                      MainPage()),(route) => false);
                // Navigator.popUntil(context, ModalRoute.withName("/"));
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => MainPage(title:"MainPage")));
              },
            ),
          ],
        ),
      ),
    );
  }
}
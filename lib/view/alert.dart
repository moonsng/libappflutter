import 'package:flutter/material.dart';

class alertList extends StatefulWidget {
  @override
  _alertListState createState() => _alertListState();
}

class _alertListState extends State<alertList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('알림'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children:<Widget> [
              Text('알림 리스트 보기 페이지')
            ],
          ),
        ),
      ),
    );
  }
}


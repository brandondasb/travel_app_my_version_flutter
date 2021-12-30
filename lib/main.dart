import 'package:flutter/material.dart';
import 'package:travel_app_my_version/Home_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Budget test',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home(),
    );
  }
}

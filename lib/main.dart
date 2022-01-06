import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_my_version/views/first_view.dart';

import 'home_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Budget test',
      theme: ThemeData(primarySwatch: Colors.green),
      // home: Home(),
      home: FirstView(),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => Home(),
        '/home': (BuildContext context) => Home()
      },
    );
  }
}

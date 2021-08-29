import 'package:flutter/material.dart';
import 'package:mysql_try/src/screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}



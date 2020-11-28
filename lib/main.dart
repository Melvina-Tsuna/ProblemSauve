import 'package:flutter/material.dart';
import 'package:sauve_moi/pages/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SauveMoi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.grey,
      ),
      home: Home(),
    );
  }
}

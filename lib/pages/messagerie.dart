import 'package:flutter/material.dart';
import 'package:sauve_moi/widgets/header.dart';
import 'package:sauve_moi/widgets/progress.dart';

class Messagerie extends StatefulWidget {
  @override
  _MessagerieState createState() => _MessagerieState();
}

class _MessagerieState extends State<Messagerie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:header(context, titleText :"Messagerie" ),
      body: circularProgress(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sauve_moi/widgets/header.dart';
import 'package:sauve_moi/widgets/progress.dart';

class Alerte extends StatefulWidget {
  @override
  _AlerteState createState() => _AlerteState();
}

class _AlerteState extends State<Alerte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:header(context, titleText :"Alertes" ),
      body: circularProgress(),
    );
  }
}

class AlerteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}

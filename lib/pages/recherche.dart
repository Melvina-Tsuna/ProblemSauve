import 'package:flutter/material.dart';
import 'package:sauve_moi/widgets/header.dart';
import 'package:sauve_moi/widgets/progress.dart';

class Recherche extends StatefulWidget {
  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:header(context, titleText :"Recherche" ),
      body: circularProgress(),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true ),
      body: circularProgress(),
    );
  }
}

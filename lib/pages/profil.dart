import 'package:flutter/material.dart';
import 'package:sauve_moi/widgets/header.dart';


class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText :"Profil" ),
      body: Text("Profile"),
    );
  }
}

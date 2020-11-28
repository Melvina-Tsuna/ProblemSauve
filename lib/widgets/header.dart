import 'package:flutter/material.dart';
AppBar header(context, {  bool isAppTitle = false, String titleText   }) {
  return AppBar(
    title: Text(
      isAppTitle ? "SauveMoi" : titleText ,
      style: TextStyle(
        color: Colors.white,
        fontFamily:  "Signatra",
        fontSize: 50.0 ,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColorDark,
  );
}


import 'package:flutter/material.dart';
import 'package:sauve_moi/widgets/header.dart';
import 'package:sauve_moi/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
class Filactualite extends StatefulWidget {
  @override
  _FilactualiteState createState() => _FilactualiteState();
}
class _FilactualiteState extends State<Filactualite> {

  @override
  void initState(){
    super.initState();
  }
  getUsers()
  {
    usersRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data);
      });
    });
  }
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true ),
      body: circularProgress(),
    );
  }
}

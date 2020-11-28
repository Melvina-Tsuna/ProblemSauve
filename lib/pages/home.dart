import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sauve_moi/pages/create_account.dart';
import 'package:sauve_moi/pages/profil.dart';
import 'package:sauve_moi/pages/recherche.dart';
import 'package:sauve_moi/pages/alerte.dart';
import 'package:sauve_moi/pages/filactualite.dart';
import 'package:sauve_moi/pages/messagerie.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final DateTime timestamp = DateTime.now();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }


  createUserInFirestore() async {
    // 1) check if user exists in users collection in database (according to their id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    final DocumentSnapshot doc = await usersRef.doc(user.id).get();

    if (!doc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      // 3) get username from create account, use it to make new user document in users collection
      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": " ",
        "timestamp": timestamp,
      });
    }
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }


  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });

  }


  onTap (int pageIndex ){
    pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut
    );}

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          //Filactualite(),
          RaisedButton(
            child: Text('Logout'),
            onPressed: logout,
          ),
          Alerte(),
          Recherche(),
          Messagerie(),
          Profil(),
        ],
        controller: pageController ,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex ,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColorDark ,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot),),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active),),
          BottomNavigationBarItem(icon: Icon(Icons.search,),),
          // size:35.0,
          BottomNavigationBarItem(icon: Icon(Icons.message),),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),),

        ],
      ),
    );


    /*return RaisedButton(
      child: Text('Logout'),
      //onPressed: logout,
    );*/
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).accentColor.withGreen(50),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'SauveMoi',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/google_signin_button.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/auth/auth.dart';
import 'package:support/pages/common/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: MyApp(),
      // home: Splash(),
    ),
  );
}

///MyApp is the main app of the Widget tree, used to login the user and connect
///him to firebase
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseApp firebase;
  UserCredential user;

  Future _setup() async {
    //Splash dura almeno un secondo
    await Future.delayed(const Duration(seconds: 1), () {});
    if (firebase == null) firebase = await Firebase.initializeApp();
    if (user == null) user = await FirebaseAuth.instance.signInAnonymously();
    return;
  }

  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    return FutureBuilder(
      future: _setup(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("errors");
        } else if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => RcaUser(firebaseUser: user),
            child: Auth(),
          );
        }
        return Splash();
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/common/splash.dart';
import 'package:support/pages/index.dart';
import 'package:support/pages/login/login.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    RcaUser user = Provider.of<RcaUser>(context);
    print("login/logout");
    return StreamBuilder(
      stream: user.loggingStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Splash();
        if (snapshot.hasError) return Text("error");
        if (snapshot.hasData) {
          DocumentSnapshot doc = snapshot.data;
          if (doc.exists) {
            if (user.isEmpty()) user.populateUserFromSession();
            return Index();
          } else {
            return Login();
          }
        }
        return Text("error");
      },
    );
  }
}

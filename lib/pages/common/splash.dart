import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          "assets/gifs/clerk.gif",
          fit: BoxFit.contain,
          height: 200,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MissingLocationAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/locationLogo.png",
            fit: BoxFit.contain,
            height: 154,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 45,
          ),
          Text(
            "Nessun locale connesso, seleziona un locale facendo click sul banner in alto",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
    );
  }
}

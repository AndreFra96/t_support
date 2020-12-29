import 'package:flutter/material.dart';

class FAQButton extends StatelessWidget {
  FAQButton({@required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Text(
          "?",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}

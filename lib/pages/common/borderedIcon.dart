import 'package:flutter/material.dart';

class BorderedIcon extends StatelessWidget {
  const BorderedIcon(
      {Key key,
      @required this.icon,
      @required this.width,
      @required this.height})
      : super(key: key);

  final Icon icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[50],
      ),
      width: width,
      height: height,
      child: icon,
    );
  }
}

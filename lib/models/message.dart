import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  bool _incoming;
  String _content;
  List<RaisedButton> _buttons;
  Timestamp _timestamp;

  Message({bool incoming, String content, List<RaisedButton> buttons}) {
    _incoming = incoming;
    _content = content;
    _buttons = buttons;
    _timestamp = Timestamp.now();
  }

  bool isincoming() {
    return this._incoming;
  }

  bool isOutgoing() {
    return !this._incoming;
  }

  Map<String, dynamic> toMap() {
    return {
      'incoming': _incoming,
      'txt': _content,
      'datetime': _timestamp.toDate()
    };
  }

  Widget getDefaultWidget() {
    List<RaisedButton> actualbuttons;
    if (_buttons == null) {
      actualbuttons = new List<RaisedButton>();
    } else {
      actualbuttons = _buttons;
    }
    return Align(
      alignment: _incoming ? Alignment.topLeft : Alignment.topRight,
      child: Column(
        children: [
          Card(
            color: _incoming ? Colors.lightGreen[100] : Colors.lightBlue[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _content,
              ),
            ),
          ),
          for (RaisedButton actual in actualbuttons)
            SizedBox(
              width: 100,
              height: 30,
              child: actual,
            ),
        ],
      ),
    );
  }
}

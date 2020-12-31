import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class Message {
  bool _incoming;
  Widget _content;
  Timestamp _timestamp;

  Message(
      {bool incoming = false, @required Widget content, Timestamp timestamp}) {
    _incoming = incoming;
    _content = content;
    if (timestamp == null) {
      _timestamp = Timestamp.now();
    } else {
      _timestamp = timestamp;
    }
  }

  bool isincoming() {
    return this._incoming;
  }

  bool isOutgoing() {
    return !this._incoming;
  }

  Widget content() {
    return this._content;
  }

  Timestamp timestamp() {
    return this._timestamp;
  }

  Map<String, dynamic> toMap() {
    return {
      'txt': _content, //TODO come memorizzo widget?
      'incoming': _incoming,
      'datetime': _timestamp.toDate()
    };
  }

  // Message fromMap(Map<String, dynamic> map) {
  //   Message m = Message(content: Text(""));
  //   if (map.length == 3) {
  //     m = Message(
  //       content:
  //           map['txt'] != null ? map['txt'] : "", //TODO come memorizzo widget?
  //       incoming: map['incoming'] != null ? map['incoming'] : false,
  //       timestamp: map['datetime'] != null
  //           ? Timestamp.fromDate(map['datetime'])
  //           : Timestamp.now(),
  //     );
  //   }
  //   return m;
  // }
}

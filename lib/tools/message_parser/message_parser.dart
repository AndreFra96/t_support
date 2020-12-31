import 'package:flutter/material.dart';
import 'package:support/tools/message_parser/message.dart';
import 'package:support/tools/message_parser/text_message.dart';

class MessageParser {
  static Message fromMap(Map<String, dynamic> map) {
    Message temp = TextMessage(content: Text("empty"), incoming: true);
    if (map.length == 3) {
      if (map['content'] is String) {
        //Il contenuto è una stringa
        temp = TextMessage(
          content: Text(map['content']),
          incoming: map['incoming'],
          timestamp: map['timestamp'],
        );
      } else {
        //Il contenuto non è una stringa
        //TODO: modifica per istanziare il tipo giusto
        temp = TextMessage(
          content: Text("Messaggio non di testo"),
          incoming: map['incoming'],
          timestamp: map['timestamp'],
        );
      }
    }
    return temp;
  }
}

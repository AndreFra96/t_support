import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:support/tools/message_parser/message.dart';

class ImageMessage extends Message {
  ImageMessage({Image content, bool incoming = false, Timestamp timestamp})
      : super(content: content, incoming: incoming, timestamp: timestamp);
}

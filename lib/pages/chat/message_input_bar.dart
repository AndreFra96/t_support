import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageInputBar extends StatelessWidget {
  final TextEditingController messageInputController;
  final Function sendMessage;

  MessageInputBar(
      {@required this.messageInputController, @required this.sendMessage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CupertinoTextField(
        controller: messageInputController,
        minLines: 1,
        maxLines: 5,
        padding: EdgeInsets.all(18),
        placeholder: "Messaggio...",
        prefix: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Icon(Icons.photo_camera),
        ),
        suffix: CupertinoButton(
          onPressed: sendMessage,
          child: Icon(Icons.send),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue[50],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:support/models/message.dart';
import 'package:support/models/rca_location.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/chat/faq_button.dart';
import 'package:support/pages/chat/message_bubble.dart';
import 'package:support/pages/chat/message_input_bar.dart';
import 'package:support/pages/common/missingLocationAlert.dart';
import 'package:support/services/firestore/firestore_service.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key key,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageInputController = new TextEditingController();
  ScrollController scrollController = new ScrollController();
  List<Message> msg = [
    Message(content: Text("questo è il primo messaggio"), incoming: true),
    Message(content: Text("questo è il secondo messaggio"), incoming: false),
    Message(content: Text("questo è il terzo messaggio"), incoming: true),
    Message(content: Text("questo è il quarto messaggio"), incoming: true),
    Message(content: Icon(Icons.face), incoming: false),
    Message(
        content: Image.asset(
          "assets/gifs/clerk.gif",
          fit: BoxFit.contain,
        ),
        incoming: false),
  ];

  toggleFAQ() {
    print("toggle faq");
  }

  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    RcaUser user = Provider.of<RcaUser>(context);
    RcaLocation location = user == null ? null : user.activeLocation();

    sendMessage() {
      String text = messageInputController.value.text;
      if (text.isNotEmpty) {
        user.sendTextMessage(text);
        setState(() {
          msg.add(
            Message(
              content: Text(messageInputController.value.text),
              timestamp: Timestamp.now(),
            ),
          );
        });
      }

      messageInputController.clear();
    }

    if (location == null) return MissingLocationAlert();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Stack(children: [
                Container(
                  child: SingleChildScrollView(
                    reverse: true,
                    controller: scrollController,
                    child: Column(
                      children: [
                        for (int i = 0; i < msg.length; i++)
                          MessageBubble(message: msg[i]),
                      ],
                    ),
                  ),
                ),
                FAQButton(
                  onPressed: toggleFAQ,
                ),
              ]),
            ),
            MessageInputBar(
              messageInputController: messageInputController,
              sendMessage: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBody extends StatefulWidget {
  const ChatBody({
    Key key,
  }) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  List<Message> msg = [
    Message(content: Text("questo è il primo messaggio"), incoming: true),
    Message(content: Text("questo è il secondo messaggio"), incoming: false),
    Message(content: Text("questo è il terzo messaggio"), incoming: true),
    Message(content: Text("questo è il quarto messaggio"), incoming: true),
    Message(content: Icon(Icons.face), incoming: false),
    Message(
        content: Image.asset(
          "assets/gifs/clerk.gif",
          fit: BoxFit.contain,
        ),
        incoming: false),
  ];

  addMessage(String message) {
    setState(() {
      msg.add(Message(content: Text(message), timestamp: Timestamp.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < msg.length; i++) MessageBubble(message: msg[i]),
          ],
        ),
      ),
    );
  }
}

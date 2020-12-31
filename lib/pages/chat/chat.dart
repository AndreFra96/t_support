import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_location.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/chat/faq_button.dart';
import 'package:support/pages/chat/message_bubble.dart';
import 'package:support/pages/chat/message_input_bar.dart';
import 'package:support/pages/common/missingLocationAlert.dart';
import 'package:support/pages/common/splash.dart';
import 'package:support/tools/message_parser/image_message.dart';
import 'package:support/tools/message_parser/message.dart';
import 'package:support/tools/message_parser/message_parser.dart';
import 'package:support/tools/message_parser/text_message.dart';

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
    TextMessage(content: Text("questo è il primo messaggio"), incoming: true),
    TextMessage(
        content: Text("questo è il secondo messaggio"), incoming: false),
    TextMessage(content: Text("questo è il terzo messaggio"), incoming: true),
    TextMessage(content: Text("questo è il quarto messaggio"), incoming: true),
    ImageMessage(
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
        user.sendTextMessage(text); //Salva il messaggio in firestore
        setState(() {
          msg.add(
            TextMessage(
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
                    child: StreamBuilder(
                  stream: user.messageStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Splash();
                    if (snapshot.hasError) return Text("error");
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        reverse: true,
                        controller: scrollController,
                        child: Column(
                          children: [
                            ...snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data();
                              Message m = MessageParser.fromMap(data);
                              return MessageBubble(message: m);
                            }),
                          ],
                        ),
                      );
                    }
                    return Text("error");
                  },
                )),
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

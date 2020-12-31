import 'package:flutter/material.dart';
import 'package:support/tools/message_parser/message.dart';

class MessageBubble extends StatelessWidget {
  // final Widget message;
  final Message message;

  const MessageBubble({Key key, this.message})
      : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime time = message.timestamp().toDate();
    String timestamp = time.hour.toString() + ":";
    timestamp += time.minute < 10
        ? "0" + time.minute.toString()
        : time.minute.toString();
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxBubbleWidth = constraints.maxWidth * 0.7;
        return Align(
          alignment: message.isincoming()
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxBubbleWidth),
            child: Container(
              decoration: BoxDecoration(
                color:
                    message.isincoming() ? Colors.amber[200] : Colors.blue[100],
                borderRadius: BorderRadius.only(
                  topLeft: message.isincoming()
                      ? Radius.circular(0.0)
                      : Radius.circular(10.0),
                  topRight: message.isincoming()
                      ? Radius.circular(10.0)
                      : Radius.circular(0.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: message.isincoming()
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: <Widget>[
                    message.content(),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: message.isincoming()
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          timestamp,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

class ChatBubbleUtils {
  static ChatBubble buildTextBubble(
      BuildContext context, BubbleDirection direction, String content) {
    if (direction == BubbleDirection.send) {
      return ChatBubble(
        clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 8, bottom: 8),
        backGroundColor: CupertinoColors.systemBlue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            content,
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            content,
            style: TextStyle(color: CupertinoColors.black),
          ),
        ),
      );
    }
  }
}

enum BubbleDirection {
  send,
  receive,
}

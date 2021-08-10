import 'package:chat_flutter/Constants.dart';
import 'package:chat_flutter/widgets/chat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: Constants.primaryColor,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.white,
        ),
        middle: const Text(
          'Chat Demo',
          style: TextStyle(color: CupertinoColors.white),
        ),
        trailing: CupertinoButton(
          // color: CupertinoColors.white,
          child: Icon(
            Icons.more_horiz,
            color: CupertinoColors.white,
          ),
          onPressed: () {},
        ),
      ),
      child: ChatWidget(context),
    );
  }
}

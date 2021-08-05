import 'package:chat_flutter/widgets/chat_widget.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBlue,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoColors.white,
        ),
        middle: const Text(
          'Chat Demo',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: ChatWidget(context),
    );
  }
}

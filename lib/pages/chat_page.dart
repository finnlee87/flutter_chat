import 'package:chat_flutter/Constants.dart';
import 'package:chat_flutter/widgets/chat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
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
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.more_vert,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Fluttertoast.showToast(
                msg: "This is Center Short Toast",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          },
        ),
      ),
      child: ChatWidget(context),
    );
  }
}

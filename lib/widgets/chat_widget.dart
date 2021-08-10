import 'package:chat_flutter/Constants.dart';
import 'package:chat_flutter/chat_bubble_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ChatWidget extends StatefulWidget {
  BuildContext parentContext;

  ChatWidget(this.parentContext);

  @override
  State<StatefulWidget> createState() {
    return ChatWidgetState(this.parentContext);
  }
}

class ChatWidgetState extends State<ChatWidget> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  bool _keyboardShow = false;
  bool _showToolbox = false;
  bool _hasValue = false;
  List<String> messageList = <String>[];
  BuildContext parentContext;

  ChatWidgetState(this.parentContext);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    setState(() {
      messageList.add("你好1");
      messageList.add("你好2");
      messageList.add("你好3");
      messageList.add("你好4");
      messageList.add("你好5");
      messageList.add("你好6");
      messageList.add("你好7");
      messageList.add("你好8");
      messageList.add("你好9");
      messageList.add("你好10");
      messageList.add("你好11");
    });

    Future.delayed(
        Duration(milliseconds: 100),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (MediaQuery.of(parentContext).viewInsets.bottom == 0) {
        print('键盘关闭');
        if (_keyboardShow) {
          setState(() {
            _keyboardShow = false;
          });
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      } else {
        print('键盘打开');
        setState(() {
          _keyboardShow = true;
          _showToolbox = false;
        });
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            color: CupertinoColors.white,
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _showToolbox = false;
                  });
                },
                child: NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    print(notification.metrics.pixels);
                    return true;
                  },
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 8.0),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          return ChatBubbleUtils.buildTextBubble(
                              context,
                              BubbleDirection.send,
                              messageList.elementAt(index));
                        } else {
                          return ChatBubbleUtils.buildTextBubble(
                              context,
                              BubbleDirection.receive,
                              messageList.elementAt(index));
                        }
                      },
                      itemCount: messageList.length),
                )),
          )),
          Container(
            // margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(bottom: 8, top: 8.0),
            color: CupertinoColors.systemGrey5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CupertinoButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _showToolbox = true;
                      });
                      Future.delayed(Duration(milliseconds: 100), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                    },
                    padding: EdgeInsets.all(0.0),
                    child: Image(
                      color: Constants.primaryColor,
                      image: AssetImage('assets/images/plus.png'),
                      height: 30,
                      width: 30,
                    )),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: CupertinoTextField(
                        controller: _textEditingController,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (String value) {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                          if (value.length > 0) {
                            setState(() {
                              _hasValue = true;
                            });
                          } else {
                            setState(() {
                              _hasValue = false;
                            });
                          }
                        },
                      )),
                ),
                CupertinoButton(
                    onPressed: () {
                      if (!_hasValue) {
                        return;
                      }
                      String text = _textEditingController.value.text;
                      setState(() {
                        messageList.add(text);
                        _hasValue = false;
                      });
                      _textEditingController.clear();
                      Future.delayed(Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeOut);
                      });
                    },
                    padding: EdgeInsets.all(0.0),
                    child: Image(
                      color: _hasValue
                          ? Constants.primaryColor
                          : CupertinoColors.inactiveGray,
                      image: AssetImage('assets/images/send.png'),
                      height: 30,
                      width: 30,
                    ))
              ],
            ),
          ),
          Visibility(
              visible: _showToolbox,
              child: Container(
                color: CupertinoColors.systemGrey5,
                height: 200,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 56,
                        width: 64,
                        decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: CupertinoButton(
                            onPressed: () async {
                              final AssetEntity? entity =
                                  await CameraPicker.pickFromCamera(context);
                            },
                            // padding: EdgeInsets.only(top: 32.0),
                            child: Image(
                              color: CupertinoColors.darkBackgroundGray,
                              image: AssetImage('assets/images/camera.png'),
                              height: 32,
                              width: 32,
                            )),
                      ),
                    )),
                    Expanded(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 56,
                              width: 64,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: CupertinoButton(
                                  onPressed: () async {
                                    final List<AssetEntity>? assets =
                                        await AssetPicker.pickAssets(context);
                                  },
                                  child: Image(
                                    color: CupertinoColors.darkBackgroundGray,
                                    image:
                                        AssetImage('assets/images/gallery.png'),
                                    height: 32,
                                    width: 32,
                                  )),
                            ))),
                    Expanded(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 56,
                              width: 64,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: CupertinoButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'pdf',
                                        'doc',
                                        'docx',
                                        'doc',
                                        'xlsx'
                                      ],
                                    );
                                    if (result != null) {
                                      result.files.forEach((file) {
                                        String? ext = file.extension;
                                      });
                                    }
                                  },
                                  child: Image(
                                    color: CupertinoColors.darkBackgroundGray,
                                    image: AssetImage('assets/images/file.png'),
                                    height: 32,
                                    width: 32,
                                  )),
                            ))),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

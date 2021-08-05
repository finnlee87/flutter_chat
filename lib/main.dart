import 'package:chat_flutter/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(CupertinoApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'My',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Container(),
              );
            });
          case 1:
            return Container(
              child: Center(
                child: CupertinoButton(
                  child: const Text('Button'),
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => ChatPage()));
                  },
                ),
              ),
            );
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Container(),
              );
            });
        }
        return Container();
      },
    );
  }
}

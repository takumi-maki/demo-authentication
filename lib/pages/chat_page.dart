import 'package:demo_authentication/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_post_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ログイン画面に遷移 + チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  })
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('ログイン情報: ${widget.user.email}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          await Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return const AddPostPage();
              })
          );
        },
      ),
    );
  }
}
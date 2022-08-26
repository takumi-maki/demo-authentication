import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('ログイン情報: ${widget.user.email}'),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('posts').orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView(
                      children: documents.map((document) {
                        return Card(
                          child: ListTile(
                            title: Text(document['text']),
                            subtitle: Text(document['email']),
                            // 自分の投稿の場合は、メッセージの削除ボタンを表示
                            trailing: document['email'] == widget.user.email
                                ? IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance.collection('posts').doc(document.id).delete();
                              },
                            ) : null,
                          ),
                        );
                      }
                    ).toList(),
                  );
                }
                return const Center(
                  child: Text('読み込み中...'),
                );
              },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          await Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return AddPostPage(widget.user);
              })
          );
        },
      ),
    );
  }
}
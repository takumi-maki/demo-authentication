import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_provider.dart';
import 'add_post_page.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(userProvider.notifier).state!;
    final AsyncValue<QuerySnapshot> asyncPostQuery = ref.watch(postsQueryProvider);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('ログイン情報: ${user.email}'),
          ),
          Expanded(
              child: asyncPostQuery.when(
                data: (QuerySnapshot query) {
                    return ListView(
                      children: query.docs.map((document) {
                        return Card(
                          child: ListTile(
                            title: Text(document['text']),
                            subtitle: Text(document['email']),
                            // 自分の投稿の場合は、メッセージの削除ボタンを表示
                            trailing: document['email'] == user.email
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
                },
                loading: () {
                return const Center(
                  child: Text('読み込み中...'),
                );
              },
                error: (e, stackTrace) {
                  return Center(
                    child: Text(e.toString()),
                  );
                }
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
                return const AddPostPage();
              }
            ),
          );
        },
      ),
    );
  }
}
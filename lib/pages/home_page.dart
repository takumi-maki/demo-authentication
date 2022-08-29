import 'package:demo_authentication/pages/check_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ホーム'),
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
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: 'test1'),
                Tab(text: 'test2'),
                Tab(text: 'test3'),
                Tab(text: 'check_list'),
                Tab(text: 'chat'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              const Center(
                child: Text('test1', style: TextStyle(fontSize: 32.0)),
              ),
              const Center(
                child: Text('test2', style: TextStyle(fontSize: 32.0)),
              ),
              const Center(
                child: Text('test3', style: TextStyle(fontSize: 32.0)),
              ),
              CheckListPage(),
              const ChatPage()
            ],
          ),
        )
    );
  }
}

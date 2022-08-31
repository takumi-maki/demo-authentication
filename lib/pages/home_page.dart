import 'package:demo_authentication/pages/check_list_page.dart';
import 'package:demo_authentication/pages/google_login_page.dart';
import 'package:demo_authentication/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleProvider = ref.watch(googleSignInProvider);
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('ホーム'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  googleProvider.logout();
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const GoogleLoginPage();
                      })
                  );
                },
              )
            ],
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: 'user'),
                Tab(text: 'test2'),
                Tab(text: 'test3'),
                Tab(text: 'check_list'),
                Tab(text: 'chat'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('id: ${googleProvider.googleSignInAccount!.id}'),
                    Text('Name: ${googleProvider.googleSignInAccount!.displayName}'),
                    Text('Email: ${googleProvider.googleSignInAccount!.email}'),
                    Text('photoUrl: ${googleProvider.googleSignInAccount!.photoUrl.toString()}'),
                    Text('serverAuthCode: ${googleProvider.googleSignInAccount!.serverAuthCode}')
                  ],
                ),
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

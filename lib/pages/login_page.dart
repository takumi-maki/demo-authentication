import 'package:demo_authentication/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../provider/app_provider.dart';
import 'chat_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoText = ref.watch(infoTextProvider);
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  ref.read(emailProvider.notifier).state = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  ref.read(passwordProvider.notifier).state = value;
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('ユーザー登録'),
                  onPressed: () async {
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.createUserWithEmailAndPassword(
                          email: email, 
                          password: password,
                      );
                      ref.read(userProvider.notifier).state = result.user;
                      await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const ChatPage();
                          }));
                    } catch (e) {
                      ref.read(infoTextProvider.notifier).state = '登録に失敗しました';
                      debugPrint(e.toString());
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    child: const Text('ログイン'),
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                        );
                        await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return const HomePage();
                            }));
                      } catch (e) {
                        ref.read(infoTextProvider.notifier).state = 'ログインに失敗しました';
                        debugPrint(e.toString());
                      }
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
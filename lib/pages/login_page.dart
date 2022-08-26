import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'chat_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String infoText = '';
  String email = '';
  String password = '';



  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('ユーザー登録'),
                  onPressed: () async {
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password
                      );
                      await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return ChatPage(result.user!);
                          }
                        )
                      );
                    } catch(e) {
                      setState(() {
                        infoText = '登録に失敗しました';
                        debugPrint(e.toString());
                      });
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
                    final result = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password
                    );
                    await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return ChatPage(result.user!);
                        }
                        )
                    );
                  } catch (e) {
                    setState(() {
                      infoText = 'ログインに失敗しました';
                      debugPrint(e.toString());
                    });
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
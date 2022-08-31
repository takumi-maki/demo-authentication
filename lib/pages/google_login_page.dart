import 'package:demo_authentication/pages/home_page.dart';
import 'package:demo_authentication/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleLoginPage extends ConsumerWidget {
  const GoogleLoginPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleProvider = ref.watch(googleSignInProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                await googleProvider.googleLogin();
                if (googleProvider.firebaseAuth.currentUser != null) {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
import 'package:demo_authentication/pages/check_list_page.dart';
import 'package:flutter/material.dart';

Future<void> achieveAlertDialog(BuildContext context, String text) async {
  return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text(text),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("達成することができましたか?")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('達成'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
  );
}


Future<void> cancelAlertDialog(BuildContext context, String text) async {
  return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text(text),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("メダルを戻しますか?")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('戻す'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
  );
}


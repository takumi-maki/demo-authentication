import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/google_view_model.dart';


final messageTextProvider = StateProvider.autoDispose((ref){
  return '';
});

final postsQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collection('posts').orderBy('date').snapshots();
});


final googleSignInProvider = ChangeNotifierProvider((ref) {
  return GoogleSignInNotifier();
});
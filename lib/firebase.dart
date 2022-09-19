import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> usercollection(int coin) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();

  DocumentReference collections = FirebaseFirestore.instance.collection('coin').doc(uid);

  collections.set({'coin':coin});
}

Future<void> dollars(int money) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();

  DocumentReference collections = FirebaseFirestore.instance.collection('dollars').doc(uid);

  collections.set({'dollars':money});
}

Future<void> extraLives(int lives) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();

  DocumentReference collections = FirebaseFirestore.instance.collection('lives').doc(uid);

  collections.set({'lives':lives});
}
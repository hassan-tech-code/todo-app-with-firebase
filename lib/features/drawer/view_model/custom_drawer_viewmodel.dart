import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_class/data/models/user_model.dart';

class CustomDrawerViewmodel extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  Stream<UserModel> getUserStream() {
    return _firestore
        .collection('users')
        .doc(_userId)
        .snapshots()
        .map(
          (snapshot) => UserModel.fromMap(snapshot.data() ?? {}, snapshot.id),
        );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

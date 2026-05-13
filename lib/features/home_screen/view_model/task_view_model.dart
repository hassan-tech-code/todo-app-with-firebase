import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  dynamic addTask() {
    FirebaseFirestore.instance.collection('todo').doc().set({
      'title': titleController.text,
      'description': descriptionController.text,
      'is_completed': false,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': userId,
    });
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  dynamic editTask(String docId) {
    FirebaseFirestore.instance.collection('todo').doc(docId).update({
      'title': titleController.text.toString(),
      'description': descriptionController.text.toString(),
    });
  }

  dynamic loadTaskData(String title, String description) {
    titleController.text = title;
    descriptionController.text = description;
  }

  dynamic deleteTask(String docId) {
    FirebaseFirestore.instance.collection('todo').doc(docId).delete();
  }

  dynamic toggleTask(String docId, bool currentState) {
    currentState = !currentState;
    FirebaseFirestore.instance.collection('todo').doc(docId).update({
      'is_completed': currentState,
    });
  }
}

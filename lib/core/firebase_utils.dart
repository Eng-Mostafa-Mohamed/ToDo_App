import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/Utils.dart';

import '../models/task_model.dart';

class Firebase_Utls {

  static CollectionReference<Task_Model> GetCollectionRef() {
    return FirebaseFirestore.instance
        .collection(Task_Model.CollectionName)
        .withConverter<Task_Model>(
        fromFirestore: (snapshot, _) =>
            Task_Model.fromfirestore(snapshot.data()!),
        toFirestore: (Task_Model, _) => Task_Model.ToFirestore());
  }

  static Future<void> AddTaskToFirestore(Task_Model task_model) {
    var collection_Ref = GetCollectionRef();
    var doc_ref = collection_Ref.doc();

    task_model.id = doc_ref.id;
    return doc_ref.set(task_model);
  }

  static Future<List<Task_Model>> GetTasksFromFire(
      DateTime selectedDate) async {
    var collection_ref = GetCollectionRef().where("selected_date",
        isEqualTo: ExtractDate(selectedDate).millisecondsSinceEpoch);
    QuerySnapshot <Task_Model> tasks = await collection_ref.get();
    List<Task_Model> tasksList = [];
    tasksList = tasks.docs
        .map(
          (e) => e.data(),
    )
        .toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<Task_Model>> GetTasksFromFireRealTime(
      DateTime selectedDate) {
    var collection_ref = GetCollectionRef().where("selected_date",
        isEqualTo: ExtractDate(selectedDate).millisecondsSinceEpoch);
    return collection_ref.snapshots();
  }

  static Future<void> DeleteTasksFromFireRealTime(Task_Model task_model) async {
    var collection_ref = GetCollectionRef();
    var documentRef = collection_ref.doc(task_model.id);
    documentRef.delete();
  }

  static Future<void> UpdateTask(Task_Model task_model) async {
    var collection_ref = GetCollectionRef();
    var documentRef = collection_ref.doc(task_model.id);
    task_model.is_completed = true;

    documentRef.update(
        task_model.ToFirestore()
    );
  }

  static Future<bool> signUp(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return Future.value(true);
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> signIn(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
      return Future.value(true);
    }

    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return Future.value(false);
      }
      return Future.value(false);
    }
    return Future.value(false);
  }
}
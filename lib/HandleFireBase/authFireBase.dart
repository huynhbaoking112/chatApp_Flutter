import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth credential = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //sign user in
  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await credential
          .signInWithEmailAndPassword(email: email, password: password);

      fireStore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email}, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await credential
          .createUserWithEmailAndPassword(email: email, password: password);

//after creating the user, create a new document for the user in the users collection]
      fireStore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future signOut() async {
    try {
      await credential.signOut();
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}

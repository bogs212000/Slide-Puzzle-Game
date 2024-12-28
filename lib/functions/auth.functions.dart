import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Future<void> SignIn(String email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> SignUp(String username, email, password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'username': username,
      'email': email,
      'score': 0,
      'rank': 0,
    });
  }
}
